export abstract class PaymentGatewayAdapter {
  abstract createCharge(data: {
    amount: number;
    customerId: string;
    paymentMethod: string;
    invoiceId: string;
  }): Promise<{ id: string; status: string; raw: any }>;

  abstract refundCharge(id: string): Promise<void>;
}
