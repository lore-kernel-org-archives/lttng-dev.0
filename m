From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: Re: [tracecompass-dev] Scalability
Date: Tue, 12 Mar 2019 11:34:37 -0400
Message-ID: <20190312153437.GA25992__47995.3167656035$1552404897$gmane$org@joraj-alpa>
References: <559e65b28a33c3a2d28bc5a32c3fdc4dfeacaf93.camel@blackberry.com>
 <DM6PR15MB3100B14E05117F439A6A08DE9E490@DM6PR15MB3100.namprd15.prod.outlook.com>
 <2b4e7937f739eda6102a62e736a6313c39ea5385.camel@blackberry.com>
 <20190312150314.GC13925@joraj-alpa>
 <484bb42bc0d287b251e2542e8d7e242ee72863b1.camel@blackberry.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 44JfD10htKz15yZ
 for <lttng-dev@lists.lttng.org>; Tue, 12 Mar 2019 11:34:40 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <484bb42bc0d287b251e2542e8d7e242ee72863b1.camel@blackberry.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Doug Schaefer <dschaefer@blackberry.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, "tracecompass-dev@eclipse.org" <tracecompass-dev@eclipse.org>
List-Id: lttng-dev@lists.lttng.org

On Tue, Mar 12, 2019 at 03:23:23PM +0000, Doug Schaefer wrote:
> It should be easy to generate a random one with the class I mentioned below
> and fill it with 16 million events.

Not if the problem is in the generator code ;).

> BTW, two of the int fields are 5 and 10
> bits respectively, but I'm not sure that matters (or at least it shouldn't).

Make sure to check the endian-ness of those fields.

What class? Not sure I see any reference to any.

Since you are generating CTF the error can be in the generator code. Please
provide either a trace reproducing the issue or a base reproducer. It will be
much easier overall than us trying to reproduce it blindly.

Cheers.
