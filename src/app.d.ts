type User = import('$lib/server/user').User;
type Session = import('$lib/server/session').Session;

declare global {
  namespace App {
    interface Locals {
      user: User | null;
      session: Session | null;
    }
  }
}

export { };

