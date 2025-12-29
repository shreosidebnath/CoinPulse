# CoinPulse - Real-Time Cryptocurrency Portfolio Tracker

A production-ready Ruby on Rails application for tracking cryptocurrency portfolios with real-time price updates, historical analytics, and a cyberpunk-themed UI.

![CoinPulse Dashboard](https://img.shields.io/badge/Rails-7.1.2-red) ![Ruby](https://img.shields.io/badge/Ruby-3.2.2-red) ![PostgreSQL](https://img.shields.io/badge/PostgreSQL-16-blue)

## ✨ Features

### Core Functionality
- **User Authentication** - Secure sign-up/login with Devise
- **Portfolio Management** - Create and manage multiple crypto portfolios
- **Real-Time Price Tracking** - Live cryptocurrency prices via CoinGecko API
- **Profit/Loss Analytics** - Track gains/losses with visual indicators
- **Price History Charts** - Interactive 24-hour price trend visualizations
- **Background Jobs** - Automated price updates every 5 minutes via Sidekiq

### Technical Highlights
- **Service Objects** - Clean API integration with `CoingeckoService`
- **Background Processing** - Sidekiq with scheduled jobs for price updates
- **Data Modeling** - Normalized schema with proper associations
- **Performance** - Database indexing, eager loading, query optimization
- **Responsive Design** - Cyberpunk-themed UI with Tailwind CSS

## 🛠 Tech Stack

**Backend:**
- Ruby 3.2.2
- Rails 7.1.2
- PostgreSQL 16
- Sidekiq (background jobs)
- Redis (job queue)

**Frontend:**
- Tailwind CSS (cyberpunk theme)
- Hotwire (Turbo & Stimulus)
- Chart.js (data visualization)
- Chartkick (Rails chart integration)

**APIs:**
- CoinGecko API (cryptocurrency data)

**Testing:**
- RSpec (planned)

## Installation

### Prerequisites
- Ruby 3.2.2
- PostgreSQL 16+
- Redis
- Node.js & npm

### Setup

1. **Clone the repository**
```bash
git clone https://github.com/yourusername/coinpulse.git
cd coinpulse
```

2. **Install dependencies**
```bash
bundle install
npm install
```

3. **Database setup**
```bash
rails db:create
rails db:migrate
rails db:seed
```

4. **Start Redis**
```bash
sudo service redis-server start
```

5. **Start Sidekiq (in separate terminal)**
```bash
bundle exec sidekiq
```

6. **Build assets**
```bash
npm run build
```

7. **Start Rails server**
```bash
rails server
```

Visit `http://localhost:3000`

## Usage

1. **Sign Up** - Create an account
2. **Create Portfolio** - Add a new portfolio
3. **Add Holdings** - Select coins, enter amount and purchase price
4. **Track Performance** - View real-time P&L and price charts
5. **Automatic Updates** - Prices refresh every 5 minutes automatically

## 🏗 Architecture

### Database Schema
```
User (Devise)
  ├─ has_many :portfolios

Portfolio
  ├─ belongs_to :user
  ├─ has_many :holdings
  └─ has_many :coins (through holdings)

Coin
  ├─ has_many :holdings
  └─ has_many :price_snapshots

Holding
  ├─ belongs_to :portfolio
  └─ belongs_to :coin

PriceSnapshot
  └─ belongs_to :coin
```

### Key Design Decisions

**Service Objects:** Extracted API logic into `CoingeckoService` for testability and reusability

**Background Jobs:** Used Sidekiq for non-blocking price updates, improving user experience

**Price Snapshots:** Separate table for historical data enables time-series analytics without API rate limits

**Query Optimization:** Eager loading (`includes`) prevents N+1 queries on dashboard

## Deployment

Deployed on [Render](https://render.com) with:
- PostgreSQL database
- Redis instance
- Sidekiq worker process

## Future Enhancements

- [ ] Price alerts via email/SMS
- [ ] Multiple currency support (EUR, CAD, etc.)
- [ ] Export portfolio to CSV
- [ ] API rate limiting
- [ ] Comprehensive test suite
- [ ] CI/CD pipeline

## Developer

**Sreo Debnath**
- Software Engineering Student, University of Calgary
- debnathahshreosi@gmail.com

---

Built as a technical showcase for Ruby on Rails proficiency, demonstrating full-stack development, API integration, background processing, and production-ready architecture.
```

