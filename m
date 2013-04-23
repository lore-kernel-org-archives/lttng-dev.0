From: Yannick Brosseau <yannick.brosseau@gmail.com>
Subject: Re: GSoC 2013 idea: support a new language binding for
 lttng
Date: Tue, 23 Apr 2013 08:39:06 -0400
Message-ID: <517680EA.50203__12757.0501099855$1366720791$gmane$org@gmail.com>
References: <CAMMh03NCLpR453cAco3aWrmw63BLGJPa+CVane0xTk6ADhr8zw@mail.gmail.com>
	<CAGDH53mzO04Cktp1ggJ8sW_zDfY7j5St20-P4xswKa2a9D4CYg@mail.gmail.com>
	<CA+jJMxtJPH0JNUMH0bZHdO6b0yeN_2wvqoyrwAaRamKcNU8VkA@mail.gmail.com>
	<CAMMh03PSP00DMVqy37DogVZGZCi70just9QMH2XvafjdG=vB8Q@mail.gmail.com>
	<CAEzWAe+7zw9=nOLNCsXFcjtz18bGo=rOeV_YTsGJrYZHRJy1QA@mail.gmail.com>
	<CAMMh03MVH=Te=BbQoofqdmZwjEJD-RJE14Ga1PpcSfTn-YEp3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qe0-f47.google.com ([209.85.128.47])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <yannick.brosseau@gmail.com>) id 1UUcVE-0001XC-Qe
	for lttng-dev@lists.lttng.org; Tue, 23 Apr 2013 08:39:20 -0400
Received: by mail-qe0-f47.google.com with SMTP id k5so316790qej.6
	for <lttng-dev@lists.lttng.org>; Tue, 23 Apr 2013 05:39:15 -0700 (PDT)
In-Reply-To: <CAMMh03MVH=Te=BbQoofqdmZwjEJD-RJE14Ga1PpcSfTn-YEp3A@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Xiaona Han <xiaonahappy13@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On 2013-04-15 10:25, Xiaona Han wrote:
> Hi Yannick
>    Thanks for your encouragement. I take a quick look at the source
> code of lttng and find that lttng-tools has python bindings code. It
> means that support Lua bindings mainly need finish the code,
> documentations and tests for the lttng-tools. What about babeltrace?
> Do we need support  Lua bindings for babeltrace APIs in this project?
Hi Xiaona,

I taken a look at your proposal for GSoC. As you say here, looking at
the babeltrace API could also be interesting and could fit very well in
the time frame. Last year, we had an intern doing the binding for Python
and i fitted well in 4 months.
I would also suggest, that you add some exploration for the addition of
UST tracepoint to the lua language. This one is probably more
complicated, so it might be added to the description as an additionnal
item if time permit.

Yannick
