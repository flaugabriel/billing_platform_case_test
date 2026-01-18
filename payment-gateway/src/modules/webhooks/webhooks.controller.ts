import { Controller, Post, Body } from '@nestjs/common';
import axios from 'axios';

@Controller('webhooks')
export class WebhooksController {
  @Post('pagarme')
  async handlePagarme(@Body() event: any) {
    const unified = this.mapStatus(event.data.status);

    await axios.post(process.env.BILLING_WEBHOOK_URL, {
      charge_id: event.data.id,
      status: unified,
      raw: event,
    });

    return { ok: true };
  }

  mapStatus(status: string) {
    switch (status) {
      case 'paid':
        return 'paid';
      case 'authorized':
        return 'authorized';
      case 'refused':
        return 'refused';
      default:
        return 'processing';
    }
  }
}
