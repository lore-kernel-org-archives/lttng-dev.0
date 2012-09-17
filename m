From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Userspace tracing, TP declaration via C++
Date: Mon, 17 Sep 2012 09:01:47 -0400
Message-ID: <20120917130147.GB4256__15750.3594448373$1347887265$gmane$org@Krystal>
References: <386C5D4D5C53C24CBC2C60CAAFD2136A170E5A3E@EXDAG0-B1.intra.cea.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TDaxR-0001OG-Ec
	for lttng-dev@lists.lttng.org; Mon, 17 Sep 2012 09:01:49 -0400
Content-Disposition: inline
In-Reply-To: <386C5D4D5C53C24CBC2C60CAAFD2136A170E5A3E@EXDAG0-B1.intra.cea.fr>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: RADERMACHER Ansgar 206501 <Ansgar.RADERMACHER@cea.fr>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

* RADERMACHER Ansgar 206501 (Ansgar.RADERMACHER@cea.fr) wrote:
> Hello,
> 
> I'd like to use LTTng in the context of C++ projects. Unless I missed something, the trace provider iitself is always a "c" file, in the examples called tp.c (I use the 2.0.5. of the LTTng tools, linux kernel 3.1.10 and gcc/g++ 4.6.2).
> 
> If I use a C++ file instead, e.g. by renaming the tp.c to tp.cpp, the compilation fails, since the two enumerations alloc and sync are defined within the scope of the lttng_ust_lib_ring_buffer_config structure and thus their literals are not found (there are additional problems, if I try to define these two enumerations on top level).
> 
> Using a c file instead of a C++ is a bit problemaitc, since I am currently integrating LTTng into the Papyrus code generation and I do not like mixing the C and C++ code generation (although possible).
> 
> Is there a know work-around or upcoming solution to declare a tracepoint and compile it with g++ ?

Not at this point. The probe needs to be compiled with gcc.

Please file a feature request on bugs.lttng.org.

Thanks,

Mathieu

> 
> Best regards
> 
> Ansgar
> 

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
