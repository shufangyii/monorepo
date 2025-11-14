import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { ClientsModule, Transport } from '@nestjs/microservices';
import { join } from 'path';

@Module({
  imports: [
    ClientsModule.register([
      {
        name: 'GREETER_PACKAGE',
        transport: Transport.GRPC,
        options: {
          package: 'ai_pack.v1',
          protoPath: join(__dirname, '../../contracts/proto/ai.proto'),
          url: 'ai:50051',
        },
      },
    ]),
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
