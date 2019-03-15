From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: Re: [tracecompass-dev] Scalability
Date: Fri, 15 Mar 2019 10:56:29 -0400
Message-ID: <20190315145629.GB6994__38538.8268435904$1552661820$gmane$org@joraj-alpa>
References: <559e65b28a33c3a2d28bc5a32c3fdc4dfeacaf93.camel@blackberry.com>
 <DM6PR15MB3100B14E05117F439A6A08DE9E490@DM6PR15MB3100.namprd15.prod.outlook.com>
 <2b4e7937f739eda6102a62e736a6313c39ea5385.camel@blackberry.com>
 <20190312150314.GC13925@joraj-alpa>
 <484bb42bc0d287b251e2542e8d7e242ee72863b1.camel@blackberry.com>
 <dfd2c677-b134-8675-e5a7-5307ac4b5ca9@versatic.net>
 <a0cbd2107e8e5321eaffe995344a22ed041db510.camel@blackberry.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 44LTDk0cr4z16Jy
 for <lttng-dev@lists.lttng.org>; Fri, 15 Mar 2019 10:56:37 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <a0cbd2107e8e5321eaffe995344a22ed041db510.camel@blackberry.com>
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

Hi Doug,

On Fri, Mar 15, 2019 at 02:17:04PM +0000, Doug Schaefer wrote:
> Hi Genevi=E8ve, thanks for this.
> =

> For now, I'm focused on libbabeltrace. I think this is something my users=
 will like to work with. They're mainly C hacks working on our kernel to st=
art. I think they'll also like using the python bindings.

Did you have a look at these projects?

LTTng-analyses : https://github.com/lttng/lttng-analyses
LTTng-lami (Machine interface spec) : https://github.com/lttng/lami-spec

It might be a good starting point or example for what can be achieved via t=
he
binding. Keep in mind that these projects are *experimental*.

Cheers
