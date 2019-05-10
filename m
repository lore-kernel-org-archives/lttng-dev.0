From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: Re: [PATCH lttng-ust v2] Fix: allocate ts_end in
 ringbuffer shared memory
Date: Fri, 10 May 2019 14:19:50 -0400
Message-ID: <20190510181950.GB24050__42580.3757434309$1557512407$gmane$org@joraj-alpa>
References: <20190510152632.8730-1-gabriel.pollo-guilbert@efficios.com>
 <c9f0e5ee-14ed-a2e7-1113-49a77bc7312a@gydle.com>
 <20190510180851.GG15644@joraj-alpa>
 <20190510181626.GA24050@joraj-alpa>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 450z5M44Xzz1K76
 for <lttng-dev@lists.lttng.org>; Fri, 10 May 2019 14:19:51 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 1B9531E26AC
 for <lttng-dev@lists.lttng.org>; Fri, 10 May 2019 14:19:51 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20190510181626.GA24050@joraj-alpa>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Sebastien Boisvert <sboisvert@gydle.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

> > 
> > This is probably an artefact but all your path have 2.9 in them. This work is
> > done against master of lttng-tools and lttng-ust.
> > 
> > Our CI does not indicate any failure for the master branches. [1]
> > 
> > [1] 
> 
> A bit quick on the send email on that one.
> 
> Our ci currently indicate failure for the master branch but nothing during the
> build process (at make check).

Again not true, failures are related to urcu.

I'll go get some coffee clearly need it.

Cheers
