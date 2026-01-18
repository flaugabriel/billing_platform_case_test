import { PaymentGatewayAdapter } from '../gateway.adapter';

export class FakeGatewayAdapter implements PaymentGatewayAdapter {
  async createCharge(data: any) {
    return {
      id: `fake_${Math.random().toString(36).substring(2)}`,
      status: 'processing',
      raw: data,
    };
  }

  async refundCharge(id: string) {
    return;
  }
}
