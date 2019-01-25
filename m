From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: Re: how to become tracing group member
Date: Fri, 25 Jan 2019 10:08:10 -0500
Message-ID: <20190125150810.GA24213__42818.3095342078$1548428920$gmane$org@joraj-alpa>
References: <CACJrnZNWmmz+t_QBpcsw2PoE5ybVH3_-ZOby6n8y651Vc0-rhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 43mMpt1x1jzp4S
 for <lttng-dev@lists.lttng.org>; Fri, 25 Jan 2019 10:08:22 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <CACJrnZNWmmz+t_QBpcsw2PoE5ybVH3_-ZOby6n8y651Vc0-rhA@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Urmila R <urmilarajpurohith@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Please keep interaction on the mailing list.

On Fri, Jan 25, 2019 at 09:13:44AM +0530, Urmila R wrote:
> Hello
> 
> To run session daemon as a root  one should be member of tracing group
> is it mandatory ?

To perform kernel tracing, lttng-sessiond daemon MUST be run as root since
it must load kernel modules.

Now to interact with and control a kernel tracing session one must be part of
the "tracing" group or be root.

> if it is can u let me know how to become tracing group member.

Again, from the doc [1]:

"The default tracing group name is *tracing*; you can set it to something else with the --group option when you start the root session daemon."

[1] https://lttng.org/docs/v2.10/#doc-start-sessiond

At this point you can google:
    how to create group on linux?
    how to add user to a group on linux?

Cheers.

-- 
Jonathan Rajotte-Julien
EfficiOS
