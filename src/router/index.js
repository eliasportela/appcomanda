import Vue from 'vue'
import Router from 'vue-router'

import Home from '@/components/Home'

//cliente
import ComandaCliente from '@/components/cliente/ComandaCliente'
import CardapioCliente from '@/components/cliente/CardapioCliente'
import PedidosCliente from '@/components/cliente/PedidosCliente'

//Garcom
import LoginGarcom from '@/components/garcom/Login'
import ComandaGarcom from '@/components/garcom/ComandaGarcom'
import ComandaDetalhes from '@/components/garcom/ComandaDetalhes'

Vue.use(Router)

export default new Router({
  mode: 'history',
  routes: [
    {
      path: '/',
      name: 'Home',
      component: Home
    },
    {
      path: '/comanda',
      name: 'ComandaCliente',
      component: ComandaCliente
    },
    {
      path: '/cardapio',
      name: 'CardapioCliente',
      component: CardapioCliente
    },
    {
      path: '/pedidos',
      name: 'PedidosCliente',
      component: PedidosCliente
    },
    {
      path: '/login',
      name: 'LoginGarcom',
      component: LoginGarcom
    },
    {
      path: '/comanda-garcom',
      name: 'ComandaGarcom',
      component: ComandaGarcom
    },
    {
      path: '/comanda-detalhes/:id',
      name: 'ComandaDetalhes',
      component: ComandaDetalhes
    }
  ]
})
