import Cookies from 'js-cookie'
import { tokenConfig } from '@/config/network.config'
const TokenKey = tokenConfig.header

export function getToken() {
  return Cookies.get(TokenKey)
}

export function setToken(token) {
  return Cookies.set(TokenKey, token, { expires: tokenConfig.expireTime })
}

export function removeToken() {
  return Cookies.remove(TokenKey)
}
