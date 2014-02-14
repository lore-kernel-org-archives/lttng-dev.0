From: "Woegerer, Paul" <Paul_Woegerer@mentor.com>
Subject: Re: RFC: Fix crash in dlerror()
Date: Fri, 14 Feb 2014 12:35:59 +0100
Message-ID: <52FDFF9F.4000206__33909.1024049141$1392377908$gmane$org@mentor.com>
References: <52F55511.2080309@mentor.com> <52FCCCD2.9050302@mentor.com>
	<610029715.24333.1392300717731.JavaMail.zimbra@efficios.com>
	<1692042945.24342.1392301795996.JavaMail.zimbra@efficios.com>
	<1119459836.24348.1392302831554.JavaMail.zimbra@efficios.com>
	<52FCE732.9090508@mentor.com>
	<581364674.24417.1392309613306.JavaMail.zimbra@efficios.com>
	<52FCF7F5.9070908@mentor.com>,
	<934762932.24558.1392317539645.JavaMail.zimbra@efficios.com>,
	<A30AF42E15BD64459E202697468DFFA77E387F33@EU-MBX-04.mgc.mentorg.com>
	<A30AF42E15BD64459E202697468DFFA77E389F61@EU-MBX-04.mgc.mentorg.com>
	<52FD4AB0.4060203@mentor.com>
	<alpine.LNX.2.00.1402141420420.24828@monopod.intra.ispras.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Paul_Woegerer@mentor.com>) id 1WEH5P-0001ty-Sh
	for lttng-dev@lists.lttng.org; Fri, 14 Feb 2014 06:37:45 -0500
In-Reply-To: <alpine.LNX.2.00.1402141420420.24828@monopod.intra.ispras.ru>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Alexander Monakov <amonakov@ispras.ru>, Stefan Seefeld <stefan_seefeld@mentor.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: lttng-dev@lists.lttng.org

Thank you Alexander !

So Stefans reasoning was entirely correct but the definition of dlsym()
lies about its effect on others.
...which makes GCC believe that there is no need to store the changes to
the cur_alloc fields prior to calling dlsym().

So I agree with you that this is a glibc bug then.

--
Best,
Paul

On 02/14/2014 11:30 AM, Alexander Monakov wrote:
> On Thu, 13 Feb 2014, Stefan Seefeld wrote:
>> Our compilation unit defines a bunch of functions with external linkage,
>> which access cur_alloc. And since gcc has no way to rule out that the
>> call to dlsym() will not cause any of these functions to be called, it
>> mustn't make any assumptions about whether or not the first
>> initialization of cur_alloc is redundant or not, and thus shouldn't
>> elide it.
> Stefan, LTTng developers,
>
> The problem here is that glibc declares dlsym() with __attribute__((leaf))
> (see the definition of __THROW in /usr/include/sys/cdefs.h and the difference
> from __THROWNL).  Presence of the attribute allows the compiler to assume that
> no functions from the current compilation unit will be called from dlsym, and
> thus there's no need to write back potentially escaping data.
>
> glibc used to have __THROW annotations on dlopen() as well, and they changed
> it to __THROWNL (removing the "leaf" attribute) after it was pointed out that
> dlopen will call constructors:
>
> https://sourceware.org/ml/libc-alpha/2013-08/msg00465.html
>
> Unfortunately when I pointed out that dlsym is not really "leaf" as well, my
> argument was dismissed:
>
> https://sourceware.org/ml/libc-alpha/2013-09/msg00012.html
>
> Please consider filing a glibc bug or otherwise reopening that discussion.
>
> Hope that helps,
> Alexander


-- 
Paul Woegerer, SW Development Engineer
Sourcery Analyzer <http://go.mentor.com/sourceryanalyzer>
Mentor Graphics, Embedded Software Division
