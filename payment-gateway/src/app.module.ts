import { Module } from '@nestjs/common';
import { ChargesModule } from './modules/charges/charges.module';
import { WebhooksModule } from './modules/webhooks/webhooks.module';
import { GatewaysModule } from './modules/gateways/gateways.module';

@Module({
  imports: [ChargesModule, WebhooksModule, GatewaysModule],
})
export class AppModule {}
