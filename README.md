## 1. BOOK NAME - HISTORY'S FUTURE
This site contains excerpts from the book I have been writing for some time, but it is not complete as yet.

** The book's name is History's Future, the tagline is "The Singularity is Here"
** In this book, I talk about the coming technological singularity.

## 2. WEBSITE: https://mehanonline.com/
** S3 BUCKET:

**AWS Route 53** — DNS management
**AWS SES** — email sending (contact form + newsletter welcome emails)
 
S3 URI: s3://mehanonline-com-site/index.html, https://mehanonline-com-site.s3.us-east-1.amazonaws.com/index.html
Bucket ARN: arn:aws:s3:::mehanonline.com
AWS VPC ID: vpc-0269574189549437b
AWS Account: 120358397452
US East (N. Virginia) us-east-1
Access Point Alias: mehanonline-wdferh35miu3go3p3dp6m11bbdh5euse1a-s3alias

This site will be published on mehanonline.com on my AWS S3. DNNSEC for mehanonline.com is enabled, and the site is live, but it does not have anything on it as yet. It just has a folder with space images

## 3. WHAT THIS PROJECT IS ABOUT:
1. I, Ashok Mehan is writing a book titled **"History's Future"**, tagline **"The Singularity Is Here"** — a first-person, autobiographical book on AI, cosmology, and the technological singularity. This Project supports two intertwined goals:
2. **The book itself** — manuscript, chapter structure, autobiographical material, research.
3. **The author website**, `mehanonline.com` — the public home for the book, essays, and curated research, built and maintained by Ashok.

## 5. Content & voice

- **Voice:** first-person, autobiographical, intellectually ambitious, mixes humor with serious subject matter.
  
  ## 4a. PROJECTS:
Going forward, new separate tasks will be put under this section. You should treat all text I develop as instructions for you to create those artifacts.

** I want to publish many essays and articles related to my story from extracts from the book I am writing.
** I would like to post, with your help, every week on: https://mehanonline.com/research/.

**Canonical pipeline:**
	Local Mac (~/mehanonline, ~/mehanonline-articles)
	        │  (edit, review, chat with GPT, Claude or Gemini)
	        ▼
	GitHub  (bomjig25/MyBook)
	        │  (git push)
	        ▼
	AWS EC2 S3 (/var/www/html)
	        │  (nginx serves it)
	        ▼
	https://mehanonline.com


## PURPOSE & CONTEXT
1. Ashok Mehan is the sole author and operator of mehanonline.com — a personal author site for his book *History's Future: The Singularity Is Here* (AI, cosmology, the technological singularity).
   
3. The site will be stored on m5pro `~/mehanonline`, Ashok's new Mac. Treat it as the single source of truth; files flow local → GitHub → EC2.

## 3. DESCRIPTION
You are my personal content editor, content creation assistant, and an advanced AI collaborator. Because your context window may reset across sessions, you might suffer from "amnesia"—forgetting yesterday's progress, repeating previous debugging steps, or rewriting code that was already rejected. This file is your external memory. You MUST read it and use it to update your own README.MD file to maintain continuity. This file is only mine to edit; don't edit it. 

## 5. Create An SQLite Database:
Create an SQLite database on S3 and use that to store new signups from my website. I have enabled AWS SES on my account, so you should use it to configure all outgoing emails.

Add all the social links noted below to be added to my author.html page when you create it, and also on the about.html page on mehanonline.com. You also need to post to these accounts, as per the following social media accounts:

## 6. Social Media: 
## X, Facebook, and LinkedIn accounts
* Facebook at: [https://www.facebook.com/ashok.mehan/](https://www.facebook.com/ashok.mehan/)
* LinkedIn at: [https://www.linkedin.com/in/ashokmehan/](https://www.linkedin.com/in/ashokmehan/)
* X it is at: [https://x.com/MehanAshok](https://x.com/MehanAshok)

*
Articles about the beginning of time, the Big Bang, evolution, and how humans got here
The story ties our beginning to where the world is headed, with uploaded minds, matrioshka brains, and pillaging the planets

**Deploys should happen automatically** — I don't want any manual process to deploy. You should render the site locally on localhost for me, and provide a button that can run a script to deploy on mehanonline.com. The workflow is as follows:

### Intended workflow (once secret is set)
	edit locally → ./deploy-mehanonline-script.sh "commit message"
	                    ↓
	              git commit + push to GitHub (main)
	                    ↓
	           GitHub Actions: rsync → on EC2 S3

If local/GitHub/AWS ever seem out of sync, the most common cause is simply that this script hasn't been run since the last edit.

**Never break existing links.** Before changing any page's URL, filename, or internal link structure, check what currently links to it (grep the repo, and ideally check the live server too) and update every reference, or don't make the change. After any edit that touches links, verify the changed page still resolves and nothing else 404s. If you can't verify, say so explicitly rather than assuming it's fine.

## Design System
- **Fonts**: Fraunces (serif display — headings, drop caps, pullquotes), Space Grotesk (body), JetBrains Mono (labels/code/captions)
- **Palette**: `#e0a44a` amber, `#0d0f12` dark bg, `#ece6da` light text, `#9aa0a8` muted
- **Nav**: "Ashok Mehan." branded dropdown. Submenus: Home / About / Artificial Intelligence / Articles / Contact. Click-to-open submenus. Hamburger at 760px.

- **Shared** — manage nav/footer across all pages
- **Cache busting**: Increment the version number when making  changes to force browser refetch.
---- 

## ROUTING OF CONTACTS USING SES
Route all `/api/` traffic to the site (except `/api/contact` which goes to a designated port).
- `/api/subscribe` — stores email in SQLite, sends welcome email via SES
- `/api/unsubscribe` — marks subscriber as unsubscribed
- `/api/contact` (fallback)
- `/api/health`
- `/contact` — sends contact form emails via SES, no DB storage

- ### Anti-spam (Two services)
- **Honeypot**: hidden `website` field in forms. Bots fill it → silent 200 drop. Humans never see it.
- **Rate limiting**: max 5 requests/IP/hour (in-memory defaultdict, resets on restart)

Schema: `id, email (UNIQUE), name, signed_up_at, confirmed, unsubscribed`
5 legitimate subscribers:
- bomjig25@gmail.com, amehan@icloud.com, mehan2325@gmail.com, ashok@ashokmehan.com, amehan@mehanonline.com

- **Essay filename convention**: `articles/article-00N-[slug].html`

- **Essay style rules**:
- Body text: Space Grotesk
- Headings/drop cap / pullquotes: Fraunces only
- Sources: two-column numbered list, amber markers, back-links
- Sidebar: sticky TOC
- Labels: JetBrains Mono

**Scheduled auto-drafting**: Every 15 days at 11 pm. Drafts saved to the outputs folder and presented for Ashok's review. Ashok must approve before anything goes live — never auto-publish.

Set `EC2_SSH_KEY` secret to trigger transfer from GitHub to mehanonline. 
GitHub repo → Settings → Secrets → Actions

**Review git diff for backend dependencies before deploying** — not just visual changes.


