resource "kubernetes_deployment" "restaurant-api" {
  metadata {
    name = "restaurant-api"
    labels = {
      test = "restaurant"
    }
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        test = "restaurant"
      }
    }

    template {
      metadata {
        labels = {
          test = "restaurant"
        }
      }

      spec {
        container {
          image = "samuelmolendolff/api-restaurant:1.3.1-beta"
          name  = "api-restaurant-container"

          resources {
            requests = {
              cpu = "10m"
            }
          }

          liveness_probe {
            http_get {
              path = "/restaurant/actuator/health/liveness"
              port = 8080
            }

            initial_delay_seconds = 15
            period_seconds        = 5
            failure_threshold     = 3
          }

          readiness_probe {
            http_get {
              path = "/restaurant/actuator/health/readiness"
              port = 8080
            }

            initial_delay_seconds = 15
            period_seconds        = 5
            failure_threshold     = 3
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "LoadBalancer" {
  metadata {
    name = "load-balancer-restaurant-api"
  }
  spec {
    selector = {
      nome = "restaurant"
    }
    port {
      port = 8080
    }
    type = "LoadBalancer"
  }
}

resource "kubernetes_config_map" "restaurant-configmap" {
  metadata {
    name = "restaurant-configmap"
  }

  data = {
    SPRING_DATASOURCE_URL : "jdbc:postgresql://${var.db_host}/${var.db_name}"
    SPRING_DATASOURCE_USERNAME : var.db_user
    SPRING_DATASOURCE_PASSWORD : var.db_password
  }
}
