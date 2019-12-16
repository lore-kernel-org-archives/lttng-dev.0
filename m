From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: Re: Regarding LTTNG support for Containers
Date: Mon, 16 Dec 2019 10:40:13 -0500
Message-ID: <20191216154013.GB29567__532.457574603029$1576510849$gmane$org@joraj-alpa>
References: <fe80d2475543b3ab4fa449f4d06ee047@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 47c57g25VZz19wp
 for <lttng-dev@lists.lttng.org>; Mon, 16 Dec 2019 10:40:15 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 5E75326F024
 for <lttng-dev@lists.lttng.org>; Mon, 16 Dec 2019 10:40:14 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <fe80d2475543b3ab4fa449f4d06ee047@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Yogesh Chandolia <yogesh.chandolia@globallogic.com>
Cc: lttng-dev@lists.lttng.org, Ankur Dauneria <ankur.dauneria@ericsson.com>, pratham.p.kumar@ericsson.com
List-Id: lttng-dev@lists.lttng.org

Hi,

On Mon, Dec 16, 2019 at 12:39:33PM +0530, Yogesh Chandolia via lttng-dev wrote:
> Hi Team,
> 
> 
> 
> We are planning to use LTTng2.11 for tracing the application in user-space
> using the LTTng-UST library only. Our application will run in the
> container.

Where do you plan on running the session daemon and consumer daemon?

> 
> We have query regarding the support of LTTng-UST for the containerize
> environment.
> 
> Please let us know whether LTTng support the tracing for containerize
> application. If yes, please share the documentation of LTTng-UST support
> for container environment.
> 
> 
> Thanks & Regards,
> 
> Yogesh
> 
> Mobile: +91 9910094311
> 
> Email: yogesh.chandolia@globallogic.com
> 
> Skype ID: yogesh.chandolia@globalogicindia.onmicrosoft.com

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


-- 
Jonathan Rajotte-Julien
EfficiOS
