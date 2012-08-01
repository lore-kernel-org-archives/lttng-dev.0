From: David Goulet <david.goulet@polymtl.ca>
Subject: Re: [lttng-tools PATCH] lttng-tools python module
Date: Wed, 01 Aug 2012 10:02:30 -0400
Message-ID: <501936F6.7010800__19160.5367851027$1343829792$gmane$org@polymtl.ca>
References: <1343326167-11522-1-git-send-email-danny.serres@efficios.com>
	<50182739.3030604@polymtl.ca> <50182FEF.6070504@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <david.goulet@polymtl.ca>) id 1SwZVS-00006t-0l
	for lttng-dev@lists.lttng.org; Wed, 01 Aug 2012 10:02:34 -0400
In-Reply-To: <50182FEF.6070504@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Yannick Brosseau <yannick.brosseau@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



On 31/07/12 03:20 PM, Yannick Brosseau wrote:
> 
> On 2012-07-31 14:43, David Goulet wrote:
> 
> 
>> Apart from those minor issues, I have two questions about this patch.
> First,
>> why is the python module in src/ and not in extras/ ? I consider src/ to
>> be supported and stable code shipped with the installation and/or in
>> packages. Also, the src/ directory is the core code of lttng-tools and
>> this module is more an extra useful tool.
> 
> I'm not sure it belongs to extras, since its an actual library that do 
> something and that is installed on the system.

Yes but I see that as a very useful contribution to the project but not part
of the core of lttng-tools which is lttng-ctl, sessiond and lttng cmdline. The
point I'm getting to is that if it's in src/, the question is do we want to
support it along side of liblttng-ctl.

- From my point of view, I'm not sure it is, for now, a good idea since it adds
a considerable amount work to fully support (at least on my side) a library
that is an extra functionality and for that I see this in extras/ for now.

> 
> If you do not want it in src, we could create a top level python directory
> or a binding/python (which allows for other language later on). On the
> other hand, its a binding of the liblttng-ctl, so having the binding live
> with the lib directly can be a good idea.
> 
> We should probably do a quick survey of other projects approach.

Indeed.

Cheers!
David

> 
> 
>> Second, _IF_ this goes into src/, please move the tests to the tests/ 
>> directory else we are going to make it self contained in extras/ which
> is good
>> right now.
> 
> yes, good point.
> 
> Yannick
> 
> 
> 
> 
> 
> _______________________________________________ lttng-dev mailing list 
> lttng-dev@lists.lttng.org 
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAEBAgAGBQJQGTb2AAoJEELoaioR9I02Z1kH/1P5jyi8pmPkpYas2D1dHXYY
ZIUwdvmFBaUCOOEk4onf5tOEBMt4QtJBlURa9OvgugEOJLCHCtm2ZgUV6d6YEOzK
wyKmtel/LA7L2q4/zzpbzI2dr66zNCZ2mBW0tYP2/O7UgCPxgHA5WqJ8yeTMG/GU
f1fjhArxevH31KYKKK0dKQzEj8ZUqQlrC70SyhOUIBZPaqCMPU2hrU0noh1sKTCx
Ixd5XirGmcNIVjB9wF/M4gr2yi80aVYfNweBNuWpn8lvG1maiq7nGj/bLAM7wPo+
OGHlaknAg7LQz+7dcvZLZ4Yxx57KpMOVPyv++LApIj6/QYv3/hRoLGcHb89+Yhw=
=0vV7
-----END PGP SIGNATURE-----
