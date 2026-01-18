import { Injectable } from '@nestjs/common';
import { PaymentGatewayAdapter } from '../gateways/gateway.adapter';
import axios from 'axios';

@Injectable()
export class ChargesService {
  constructor(private readonly gateway: PaymentGatewayAdapter) {}

  async createCharge(data: any) {
    const result = await this.gateway.createCharge(data);

    return { charge_id: result.id, status: result.status };
  }
}
