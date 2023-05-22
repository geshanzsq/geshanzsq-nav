import hasRole from './permission/hasRole'
import hasPermission from './permission/hasPermission'

export default function directive(app) {
  app.directive('role', hasRole)
  app.directive('permission', hasPermission)
}
