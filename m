From: Simon Marchi <simark@simark.ca>
Subject: Re: Wrong "ar" used when cross-building lttng
Date: Thu, 14 Nov 2019 11:43:39 -0500
Message-ID: <3c62ba15-bb2d-702e-86f4-90e8decc9fb1__25857.5670932018$1573749844$gmane$org@simark.ca>
References: <2357817.GzqeBO7jDX@devpool35>
 <2e655403-71d2-ee11-3675-d9ad81d6fe85@simark.ca>
 <3241563.NbJrRt7XGO@devpool35>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from simark.ca (simark.ca [158.69.221.121])
 by lists.lttng.org (Postfix) with ESMTPS id 47DS3d18KxzrbL
 for <lttng-dev@lists.lttng.org>; Thu, 14 Nov 2019 11:43:40 -0500 (EST)
In-Reply-To: <3241563.NbJrRt7XGO@devpool35>
Content-Language: tl
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Rolf Eike Beer <eb@emlix.com>, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On 2019-11-14 11:24 a.m., Rolf Eike Beer wrote:
> Works for me.

Thanks.

> I have not checked latest git, but maybe you may want to fix this warning, 
> too?
> 
> With 2.11.0 release tarball:
> 
> -./configure: line 24663: test: -eq: unary operator expected
> 
> Greetings,
> 
> Eike

Hmm I don't remember seeing this error, and I don't see it now.

Could you please try with master?  If it still happens, you can try to
find from which line of the configure.ac or an m4 file this line comes
from.  I presume it won't be too hard to fix.

Simon
