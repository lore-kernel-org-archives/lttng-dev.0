From: David Goulet <dgoulet@efficios.com>
Subject: Re: [lttng-tools PATCH] lttng-tools python module v2
Date: Thu, 09 Aug 2012 10:52:10 -0400
Message-ID: <5023CE9A.9080505__49392.3967741013$1344523957$gmane$org@efficios.com>
References: <1344452188-7579-1-git-send-email-danny.serres@efficios.com>,
	<5022CF9F.9090500@gmail.com>, <5023C796.2030205@efficios.com>
	<BLU170-W12144FEB282856DC1FADACFC0CC0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1SzU5t-0002zx-R7
	for lttng-dev@lists.lttng.org; Thu, 09 Aug 2012 10:52:14 -0400
In-Reply-To: <BLU170-W12144FEB282856DC1FADACFC0CC0@phx.gbl>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Danny Serres <serres@live.ca>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Danny Serres:
> 
> 
>> Date: Thu, 9 Aug 2012 10:22:14 -0400 From: dgoulet@efficios.com 
>> To: yannick.brosseau@gmail.com CC: danny.serres@efficios.com;
>> lttng-dev@lists.lttng.org Subject: Re: [lttng-dev] [lttng-tools
>> PATCH] lttng-tools python module v2
>> 
> 
> Yannick Brosseau:
>> On 2012-08-08 14:56, Danny Serres wrote:
>>> The lttng-tools Python module can be used to directly control
>>> the lttng-tools API inside Python, using 'import lttng'.
> 
>>> Therefore, it becomes possible to create a trace, add events, 
>>> start/stop tracing, destroy a session and so on from within 
>>> Python.
> 
>>> The module does not include URI-related functions.
> 
>>> SWIG >= 2.0 is used to create the wrapper and its 'warning md 
>>> variable unused' bug is patched in Makefile.am.
> 
> 
>> But I don't think that stuff in "extra" should be in the build 
>> system.
> 
> Indeed. It should not.
> 
> Is it possible to create the Makefile on "configure" but not
> building the bindings with "make" ?
> 
> 
>> Sure I'll just switch the --disable-python option to
>> --enable-python in the configure.ac

This seems like a good idea. Does "--enable-python" is right. Should
we have something like "--enable-python-bindings" or
"--enable-lttngctl-python"... or ... (you get the idea) ?

David

> 
>> Danny
> 
> 
> David
> 
> 
>> _______________________________________________ lttng-dev
>> mailing list lttng-dev@lists.lttng.org 
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>> 
>> _______________________________________________ lttng-dev mailing
>> list lttng-dev@lists.lttng.org 
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJQI86XAAoJEELoaioR9I02XGcIAILmRSD/4ghVjJjggfTjxSuA
E0aKMWnXpxBO70I6CgP3Gvkab5gShjxS0juv1L2BqoqvfWfolhfRJ19kbg6+fHbl
oCYR+n1XL+7pjjQwjrKN006hEHzQXCInImX1tY0cIFZ3nfBCG6jRnyg57MM36hdC
nDs1KYHyhFiUcSKOoZ06Vis3H+YvUYo9zB7mHEf5y7pvdQgaIP01Y5d94MP33GEK
CZQpOMDfrlFD/qGe2BsFRw+zMc+O1irkXRszawK7bAekFpHuN+od1nEED2ZhxO8e
Et7mU5TQn0U9usrbCHw7lkEVDCaHri/9rjoDqWWpqbHPIdHG7O8uwqQQEtg0Qd8=
=Gsvm
-----END PGP SIGNATURE-----
