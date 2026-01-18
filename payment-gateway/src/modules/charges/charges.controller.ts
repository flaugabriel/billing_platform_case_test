import { Controller, Post, Body } from '@nestjs/common';
import { ChargesService } from './charges.service';

@Controller('charges')
export class ChargesController {
  constructor(private readonly service: ChargesService) {}

  @Post()
  async create(@Body() body: any) {
    return await this.service.createCharge(body);
  }
}
