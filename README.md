<div align="center">

# Peet Zah Mgr 🍕👨‍🍳

A Ruby on Rails web application for managing pizza toppings and custom pie creations.  
Manage available toppings, and create pies that will satisfy any customer's hunger!  
Deployed on Heroku with a PostgreSQL backend, and styled with TailwindCSS.

## Features:
Full CRUD operations for Toppings resource
</br>
Full CRUD operations for Pizzas resource
</br>
User authentication with secure password hashing
</br>
Role-based access control (`Manager` vs. `Chef`) for managing appropriate resources
</br>
Duplicate resource prevention for both enforced via model and schema validations
</br>
Responsive UI with TailwindCSS
</br>
Deployed to Heroku

</div>

---

## 🛠️ Tools Used:

| Development | Testing | Deployment |
|-------------|---------|------------|
| Ruby 3.2.3 (via `rbenv`) | RSpec | Heroku |
| Rails 7.0.8.7 | Capybara (System Specs) | |
| PostgreSQL 17.5 | Shoulda-Matchers | |
| `bcrypt` for password hashing | | |
| Node v24.4.1 - TailwindCSS (via `tailwindcss-rails`) | | |

---

### Technical Choices
This application was built with Ruby on Rails to leverage the framework's proven MVC architecture, thereby ensuring a clean separation of concerns between data models, business logic, and UI presentation layers.

Key benefits driving the technical design choices included:

1.) **ActiveRecord ORM:** Simplifies database interactions and relationships while maintaining readability. Associations between pizzas and toppings can be easily modeled without complex SQL and potential risk of SQL injection.

2.) **Validations at multiple logical layers:** Rails models enforce business rules in code, while PostgreSQL constraints ensure data integrity at the schema level. This dual-layer validation prevents duplicate records, preserves data integrity, and ultimately the end-user experience.

3.) **Built-in MVC convention:** Rails’ opinionated structure accelerates development and enforces code maintainability by keeping models, controllers, and views abstracted and well organized within relevant subdirectories.

4.) **Lightweight, flexible views:** TailwindCSS was paired with built-in Rails views for rapid, iterative UI development. This approach provides out of the box responsiveness while allowing for quicker design adjustments as requirements eventually evolve and applications reach greater maturity.

5.) **Role-based authentication and ACL:** Implemented a lightweight user model with secure password handling (`has_secure_password` via `bcrypt`) and role constants to enforce access control. Managers have full CRUD capabilities on both pizzas and toppings resources, while chefs are restricted to pizza management only. This demonstrates separation of concerns and provides a foundation for future expansion into a more robust permissions system.

6.) **Rails’ convention-over-configuration philosophy paired with a strong automated testing ecosystem (RSpec, Capybara):** Allows the application to achieve high maintainability, faster iteration cycles, and production-ready quality in a short timeframe.

---

## How to Use:

1. **Access the app:**  
   Visit the deployed application:  
   [Production App 🍕👨‍🍳](https://tvaroglu-peet-zah-mgr-prod-e9190eadf2c5.herokuapp.com/)
   
2. **Create a Manager account:**
   - Click **Create Account** on the login page.  
   - Fill in a username and password.  
   - Select **Manager 👨‍🍳** as the employee type.  
   - Managers have full CRUD access to both pizzas and toppings.  
3. **Create a Chef account:**
   - Log out and click **Create Account** again.  
   - Fill in a different username and password.  
   - Select **Chef 🍕** as the employee type.  
   - Chefs can manage pizzas only and cannot edit or delete toppings.
4. **Log in and manage resources:**
   - As a manager: create, update, and delete both toppings and pizzas.  
   - As a chef: create, update, and delete pizzas only. Toppings are visible but cannot be modified.
5. **Switch roles for testing:**
   - Use the logout button to switch between your Manager and Chef accounts to see role-based access in action.

---

### Future Extensions

- **Admin panel for user role assignment:**
  Allow managers or admins to promote/demote users, managing their roles without requiring new account setup.
- **OAuth integration:**
  Implement third-party authentication (Google, GitHub, etc.) to streamline login and user creation.
- **Audit trails & permission granularity:**
  Extend role-based ACL to track changes and restrict specific actions within pizza or topping management.


## 🛠️ Local Environment Setup

### Requirements:
- macOS or Linux (arm64 supported)
- [rbenv](https://github.com/rbenv/rbenv)
- [PostgreSQL](https://www.postgresql.org/)
- [Node + NVM](https://github.com/nvm-sh/nvm)
- [Heroku CLI](https://devcenter.heroku.com/articles/heroku-cli)

### Suggested `~/.zshrc` Configuration:
```bash
eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# Avoid Rails/Logger conflicts in Rails 7.x with RSpec 5.x versions:
export RUBYOPT="-rlogger"

# Node version management:
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && . "/opt/homebrew/opt/nvm/nvm.sh"
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && . "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

# Homebrew Postgres binary management:
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
```

### Install dependencies, build app, run tests, and local server:
```bash
# Install dependencies:
bundle install

# Create && migrate database:
bin/rails db:drop db:create db:migrate db:seed

# Compile Tailwind assets:
bin/rails tailwindcss:build

# Run test suite:
bundle exec rspec -fd

# Boot local server:
bin/rails s
```
