import { z } from "zod";

const aclSchema = z.object({
  address: z.string(),
  owner: z.string(),
  pausableAdmins: z.array(z.string()),
  unpausableAdmins: z.array(z.string()),
});

type ACLPayload = z.infer<typeof aclSchema>;

export class ACLState {
  address: string;
  owner: string;
  pausableAdmins: Array<string>;
  unpausableAdmins: Array<string>;

  constructor(payload: ACLPayload) {
    this.address = payload.address;
    this.owner = payload.owner;
    this.pausableAdmins = payload.pausableAdmins;
    this.unpausableAdmins = payload.unpausableAdmins;
  }

  static fromJson(json: string): ACLState {
    const payload = aclSchema.parse(JSON.parse(json));
    return new ACLState(payload);
  }
}
