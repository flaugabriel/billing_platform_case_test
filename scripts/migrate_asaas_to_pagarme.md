# Migração ASAAS → Pagar.me

## Objetivo
Unificar o billing removendo o ASAAS como gateway e passando a operar exclusivamente via Pagar.me.

## Estratégia
- Histórico permanece no ASAAS
- Cobranças futuras passam a ser geradas via Pagar.me
- Não há reprocessamento financeiro
- Não há duplicidade de cobranças
- Zero impacto operacional para o cliente

## Etapas

1. Exportar dados do ASAAS
2. Importar para Billing DB
3. Criar clientes no Pagar.me
4. Mapear subscriptions
5. Configurar próximo ciclo
6. Desabilitar ASAAS
7. Ativar geração no dia 1

## Campos mapeados

| ASAAS | Billing | Pagar.me |
|-------|---------|----------|
| customer.id | client.asaas_id | customer.id |
| cpfCnpj | client.document | document |
| nextDueDate | subscription.next_billing_at | - |
| billingType | subscription.payment_method | payment_method |
| value | subscription.price_cents | amount |

## Garantias

- faturas já pagas **não são cobradas**
- faturas pendentes **não são duplicadas**
- clientes não percebem troca de gateway

## Rollback

Como o histórico permanece no ASAAS, rollback consiste em:

- reativar ASAAS unilateralmente
- desativar Pagar.me no billing
