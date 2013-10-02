From: "Woegerer, Paul" <Paul_Woegerer@mentor.com>
Subject: Re: Making 32-bit user-space events on a 64-bit Linux
 system
Date: Wed, 2 Oct 2013 09:37:47 +0200
Message-ID: <524BCD4B.2020501__49340.9292227172$1380699524$gmane$org@mentor.com>
References: <48CF5AC71E61DB46B70D0F388054EFFD2679540E@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Paul_Woegerer@mentor.com>) id 1VRH0P-0003mv-2x
	for lttng-dev@lists.lttng.org; Wed, 02 Oct 2013 03:38:01 -0400
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD2679540E@VAL-E-02.valcartier.drdc-rddc.gc.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>, jeremie.galarneau@gmail.com
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi Daniel, Hi Jeremie

I tried this on my x86_64 system some time ago (with 2.2.0-rc2) and it
worked just fine.

The only thing that was needed was to build 32-bit variants of urcu and
lttng-ust (and also having all dependend libs as 32-bit variants on the
system).

The 64-bit version of lttng-tools works just fine with both, 32-bit and
64-bit userspace applications. No need to compile it as 32-bit variant.

Instrumented 32-bit applications automatically use the 32-bit
lttng-consumerd (from the lttng-ust 32-bit build),
instrumented 64-bit applications automatically use the 64-bit
lttng-consumerd (from the lttng-ust 64-bit build).

BTW, when you compile for the "-m32" multilib, it's better to use the
following:

$ ./configure CC="gcc -m32"

This way also the linking steps (performed by libtool) of your build
will know that you are building for m32 (on your x86_64 system) and you
don't need e.g. "--libdir ....".
For more information see:
http://doc.opensuse.org/documentation/html/openSUSE/opensuse-reference/cha.64bit.html#sec.64bit.biarch
or
https://developer.mozilla.org/en/docs/Compiling_32-bit_Firefox_on_a_Linux_64-bit_OS

> More generally, how does one add tracepoints to a 32-bit application running on a 64-bit system?

You simply compile your instrumented application to 32-bit the same way
you did it for the lttng-ust package (CC="gcc -m32").


Best,
Paul

-- 
Paul Woegerer, SW Development Engineer
Sourcery Analyzer <http://go.mentor.com/sourceryanalyzer>
Mentor Graphics, Embedded Software Division
