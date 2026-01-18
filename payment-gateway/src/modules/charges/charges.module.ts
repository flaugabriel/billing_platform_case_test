import { Module } from '@nestjs/common';
import { ChargesService } from './charges.service';
import { ChargesController } from './charges.controller';
import { GatewaysModule } from '../gateways/gateways.module';

@Module({
  imports: [GatewaysModule],
  controllers: [ChargesController],
  providers: [ChargesService],
})
export class ChargesModule {}
