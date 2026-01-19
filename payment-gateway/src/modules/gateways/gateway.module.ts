import { Module } from '@nestjs/common';
import { PaymentGatewayAdapter } from './gateway.adapter';
import { FakeGatewayAdapter } from  './faker/fake.adapter';
import { PagarmeGatewayAdapter } from './pagarme/pagarme.adapter';

@Module({
  providers: [
    {
      provide: PaymentGatewayAdapter,
      useClass: process.env.USE_FAKE === 'true'
        ? FakeGatewayAdapter
        : PagarmeGatewayAdapter,
    },
  ],
  exports: [PaymentGatewayAdapter],
})
export class GatewaysModule {}
