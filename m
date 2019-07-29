From: Sebastien Boisvert <sboisvert@gydle.com>
Subject: Re: [PATCH lttng-ust] Use MAP_POPULATE to reduce
 pagefault when available
Date: Mon, 29 Jul 2019 14:41:34 -0400
Message-ID: <8020a3d2-c963-d755-55f5-c6ea6117a531__42173.5588739224$1564425862$gmane$org@gydle.com>
References: <20190729182356.21025-1-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.gydle.com (mail.gydle.com [64.18.173.180])
 by lists.lttng.org (Postfix) with ESMTPS id 45y7nd32rxz1Fq1
 for <lttng-dev@lists.lttng.org>; Mon, 29 Jul 2019 14:41:41 -0400 (EDT)
In-Reply-To: <20190729182356.21025-1-jonathan.rajotte-julien@efficios.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>, lttng-dev@lists.lttng.org
Cc: guoyiteng@gmail.com
List-Id: lttng-dev@lists.lttng.org


On 2019-07-29 2:23 p.m., Jonathan Rajotte wrote:
> Any ring buffer configuration bigger than PAGE_SIZE would result
> in increase latency for the first tracepoint hit (1200ns) lending on a

in an increased latency
