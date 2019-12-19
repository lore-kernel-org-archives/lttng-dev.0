From: Yogesh Chandolia via lttng-dev <lttng-dev@lists.lttng.org>
Subject: Re: Regarding LTTNG support for Containers
Date: Thu, 19 Dec 2019 12:11:38 +0530
Message-ID: <4753e17ff492cb712eb9f7e14f950e9d__17161.3271160581$1576737776$gmane$org@mail.gmail.com>
References: <fe80d2475543b3ab4fa449f4d06ee047@mail.gmail.com>
 <20191216154013.GB29567@joraj-alpa>
Reply-To: Yogesh Chandolia <yogesh.chandolia@globallogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 by lists.lttng.org (Postfix) with ESMTPS id 47dj2v1GWHz1FhQ
 for <lttng-dev@lists.lttng.org>; Thu, 19 Dec 2019 01:41:42 -0500 (EST)
Received: by mail-il1-x12c.google.com with SMTP id f5so3935809ilq.5
 for <lttng-dev@lists.lttng.org>; Wed, 18 Dec 2019 22:41:42 -0800 (PST)
In-Reply-To: <20191216154013.GB29567@joraj-alpa>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Cc: lttng-dev@lists.lttng.org, Ankur Dauneria <ankur.dauneria@ericsson.com>, pratham.p.kumar@ericsson.com
List-Id: lttng-dev@lists.lttng.org

Hi Jonathan,

We are planning to run the session daemon and consumer daemon from the
host machine to fetch the trace points of application run inside
container.

Thanks & Regards,
Yogesh
Mobile: +91 9910094311
Email: yogesh.chandolia@globallogic.com
Skype ID: yogesh.chandolia@globalogicindia.onmicrosoft.com

-----Original Message-----
From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Sent: Monday, December 16, 2019 9:10 PM
To: Yogesh Chandolia <yogesh.chandolia@globallogic.com>
Cc: lttng-dev@lists.lttng.org; pratham.p.kumar@ericsson.com; Ankur
Dauneria <ankur.dauneria@ericsson.com>
Subject: Re: [lttng-dev] Regarding LTTNG support for Containers

Hi,

On Mon, Dec 16, 2019 at 12:39:33PM +0530, Yogesh Chandolia via lttng-dev
wrote:
> Hi Team,
>
>
>
> We are planning to use LTTng2.11 for tracing the application in
> user-space using the LTTng-UST library only. Our application will run
> in the container.

Where do you plan on running the session daemon and consumer daemon?

>
> We have query regarding the support of LTTng-UST for the containerize
> environment.
>
> Please let us know whether LTTng support the tracing for containerize
> application. If yes, please share the documentation of LTTng-UST
> support for container environment.
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
