From: David Goulet <dgoulet@efficios.com>
Subject: Re: [lttng-tools PATCH] lttng-tools python module v2
Date: Thu, 09 Aug 2012 10:22:14 -0400
Message-ID: <5023C796.2030205__10813.177660066$1344522172$gmane$org@efficios.com>
References: <1344452188-7579-1-git-send-email-danny.serres@efficios.com>
	<5022CF9F.9090500@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1SzTcx-0002jN-H6
	for lttng-dev@lists.lttng.org; Thu, 09 Aug 2012 10:22:19 -0400
In-Reply-To: <5022CF9F.9090500@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Yannick Brosseau <yannick.brosseau@gmail.com>
Cc: Danny Serres <danny.serres@efficios.com>, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512


Yannick Brosseau:
> On 2012-08-08 14:56, Danny Serres wrote:
>> The lttng-tools Python module can be used to directly control the
>> lttng-tools API inside Python, using 'import lttng'.
>> 
>> Therefore, it becomes possible to create a trace, add events, 
>> start/stop tracing, destroy a session and so on from within
>> Python.
>> 
>> The module does not include URI-related functions.
>> 
>> SWIG >= 2.0 is used to create the wrapper and its 'warning md
>> variable unused' bug is patched in Makefile.am.
>> 
> 
> But I don't think that stuff in "extra" should be in the build
> system.

Indeed. It should not.

Is it possible to create the Makefile on "configure" but not building
the bindings with "make" ?

David

> 
> _______________________________________________ lttng-dev mailing
> list lttng-dev@lists.lttng.org 
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJQI8eTAAoJEELoaioR9I02H24H/iepIFDK0qRvL1pU4S0H2EQx
iMhDNGF/CLzG/FnOWEyZgoNR6lhc1lSUjaFs6FL56VcVueBuCW07rsTJDu2NgCYz
TsHO29KAR3qrk+ymwSR53TeK2qXt8gr5AXYbc8mK0/DBWWQAxrmJXKSOy8qQ2tmV
O0OBWVayDRWttusOknZgabAZF7JBitsoIQ2ZRNRlNtqIUxlbdsQlliujEpzjBu8b
iCuZ/ZXxZ/oeClF1Pnoh64+yziHTfsBVFEbee4CpnBiRBn/6CsxEOF/ZscgWWkOl
DOUWxj739xHcbtEtWBDo8iu6eqtOCuqVi4RKPqtmk4mqme8Tj7fTQg6YIJ+SZbU=
=wKL0
-----END PGP SIGNATURE-----
