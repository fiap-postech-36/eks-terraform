resource "kubernetes_config_map" "config_map" {
  metadata {
    name = "api-configmap"
  }

  data = {
    SPRING_DATASOURCE_URL      = "jdbc:postgresql://svc-db:5432/restaurant"
    SPRING_DATASOURCE_USERNAME = var.db_username
    SPRING_DATASOURCE_PASSWORD = var.db_password
  }
}

resource "kubernetes_deployment" "deploy_app" {
  metadata {
    name      = "api-deployment"
  }

  spec {
    selector {
      match_labels = {
        app = "api-pod"
      }
    }

    template {
      metadata {
        labels = {
          app = "api-pod"
        }
      }

      spec {
        toleration {
          key      = "key"
          operator = "Equal"
          value    = "value"
          effect   = "NoSchedule"
        }

        initContainers {
          name    = "wait-for-database"
          image   =  "busybox:1.28"
          command = "['sh', '-c', 'echo Setting up API, please wait! && sleep 20']"
        }

        container {
          name  = "api-restaurant-container"
          image = "samuelmolendolff/api-restaurant:latest"

          resources {
            requests = {
              memory : "512Mi"
              cpu : "500m"
            }
            limits = {
              memory = "1Gi"
              cpu    = "1"
            }
          }

          env_from {
            config_map_ref {
              name = kubernetes_config_map.config_map.metadata[0].name
            }
          }

          port {
            container_port = var.app_port
          }

          liveness_probe {
            http_get {
              path = "/restaurante/api/v1/produto"
              port = var.app_port
            }
            initial_delay_seconds = 30
            period_seconds        = 25
            failureThreshold      = 2
          }
        }
      }
    }
  }

  depends_on = [aws_eks_node_group.node_group]
}

resource "kubernetes_service" "service_app" {
  metadata {
    name      = "svc-api"
    annotations = {
      "service.beta.kubernetes.io/aws-load-balancer-type" : "nlb",
      "service.beta.kubernetes.io/aws-load-balancer-scheme" : "internal",
      "service.beta.kubernetes.io/aws-load-balancer-cross-zone-load-balancing-enabled" : "true"
    }
  }
  spec {
    selector = {
      app = "api-pod"
    }
    port {
      port        = var.app_port
      target_port = var.app_target
    }
    type = "LoadBalancer"
  }
}

resource "kubernetes_ingress_v1" "app_ingress" {
  metadata {
    name      = "ingress-app"
  }

  spec {
    default_backend {
      service {
        name = kubernetes_service.service_app.metadata[0].name
        port {
          number = kubernetes_service.service_app.spec[0].port[0].port
        }
      }
    }
  }
}

data "kubernetes_service" "service_app_data" {
  metadata {
    name      = kubernetes_service.service_app.metadata[0].name
    namespace = kubernetes_service.service_app.metadata[0].namespace
  }
}