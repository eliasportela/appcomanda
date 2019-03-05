import Vue from 'vue'
import Router from 'vue-router'

import Home from '@/components/Home'

//cliente
import ComandaCliente from '@/components/cliente/ComandaCliente'
import CardapioCliente from '@/components/cliente/CardapioCliente'
import PedidosCliente from '@/components/cliente/PedidosCliente'

//Garcom
import LoginGarcom from '@/components/garcom/Login'
import Dashboard from '@/components/garcom/Dashboard'
import ComandaGarcom from '@/components/garcom/ComandaGarcom'
import ComandaDetalhes from '@/components/garcom/ComandaDetalhes'
import Produtos from '@/components/garcom/Produtos'
import ProdutosCadastro from '@/components/garcom/ProdutosCadastro'
import ProdutosDetalhes from '@/components/garcom/ProdutosDetalhes'

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

    //Admin
    {
      path: '/login',
      name: 'LoginGarcom',
      component: LoginGarcom
    },
    {
      path: '/dashboard',
      name: 'Dashboard',
      component: Dashboard
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
    },
    {
      path: '/produtos',
      name: 'Produtos',
      component: Produtos
    },
    {
      path: '/produtos/cadastrar',
      name: 'ProdutosCadastrar',
      component: ProdutosCadastro
    },
    {
      path: '/produtos/editar/:id',
      name: 'ProdutosEditar',
      component: ProdutosCadastro
    },
  ]
})
