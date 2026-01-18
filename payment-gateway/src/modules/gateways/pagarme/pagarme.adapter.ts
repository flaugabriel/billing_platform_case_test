import axios from 'axios';
import { PaymentGatewayAdapter } from '../gateway.adapter';

export class PagarmeGatewayAdapter implements PaymentGatewayAdapter {
  private client = axios.create({
    baseURL: process.env.PAGARME_API_URL,
    headers: {
      Authorization: `Bearer ${process.env.PAGARME_API_KEY}`,
    },
  });

  async createCharge(data: any) {
    const res = await this.client.post('/charges', data);
    return {
      id: res.data.id,
      status: res.data.status,
      raw: res.data,
    };
  }

  async refundCharge(id: string) {
    await this.client.post(`/charges/${id}/refund`);
  }
}
