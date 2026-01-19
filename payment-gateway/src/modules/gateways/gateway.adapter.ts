export abstract class PaymentGatewayAdapter {
  abstract createCharge(data: any): Promise<any>;
  abstract refundCharge(id: string): Promise<void>;
}
