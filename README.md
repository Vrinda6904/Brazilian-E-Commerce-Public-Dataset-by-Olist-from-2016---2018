# Brazilian-E-Commerce-Public-Dataset-by-Olist-from-2016---2018
SQL analysis of Brazilian e-commerce data (Olist) , revenue trends, customer segmentation, regional performance, and payment behavior insights using MySQL.
Total Revenue:								 
•	Total revenue: ~$16,008,872
Total Orders & Unique Customers:	
•	Total orders: 41,562 | Unique customers: 40,924
Insight: With unique customers (40,924) nearly equal to total orders (41,562), the vast majority of customers are one-time buyers (repeat purchase behavior is minimal). This is a major finding for an e-commerce business: customer retention, not just acquisition, is likely a bigger revenue lever than the current data shows being used.

Order Status Breakdown: 
•	Delivered: 96,478 | Shipped: 1,107 | Canceled: 625 | Unavailable: 609
Insight: Over 96% of orders reach "delivered" status, with cancellations at a fairly low ~0.6% — indicating a generally reliable fulfillment pipeline, though the "unavailable" status (609 orders) is worth flagging as inventory/stock-sync issues worth investigating.

Monthly Revenue:				 	 
Insight: Revenue grew steadily through 2017, peaking in November (likely Black Friday seasonality — worth checking). The sharp collapse in Sep–Oct 2018 almost certainly indicates the dataset simply ends mid-way through that month, not a real business decline.

Month-Over-Month Growth %:
Month-Over-Month Growth: The Nov 2017 spike (+53% MoM) stands out against an otherwise stabilized growth pattern strongly suggestive of a seasonal event (Black Friday).

Top 10 Customers by lifetime Spend:
Insight: Spend is heavily concentrated at the top — the 1st customer outspends the 2nd by 2x, and the top 10 span multiple states (RJ, MS, ES, SP, PB, MG, SC) rather than clustering in one region, suggesting high-value customers exist nationally, not just in major hubs.

Revenue by State:
Insight: SP alone drives roughly 40% of orders and revenue, consistent with it being Brazil's largest economic hub. Interestingly, average order value is lowest in SP ($137) compared to smaller states like PB ($254) and MA ($203) — suggesting SP has higher order volume but lower order value, while remote states have fewer but pricier orders (possibly due to bulk buying or higher shipping-inclusive pricing).

Payment Type breakdown:
Insight: Credit card is the primary payment method and the only one where customers spread payments across installments (avg 3.5), indicating price-sensitivity or larger basket sizes financed over time.

Delivery Performance:
Insight: While most orders arrive within or close to the estimated delivery window, isolated cases show delivery delays of 3-4 weeks beyond the estimate.
