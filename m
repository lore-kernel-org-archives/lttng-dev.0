From: Stefan Seefeld <stefan_seefeld@mentor.com>
Subject: Re: RFC: Fix crash in dlerror()
Date: Thu, 13 Feb 2014 17:44:00 -0500
Message-ID: <52FD4AB0.4060203__9609.71026584065$1392331514$gmane$org@mentor.com>
References: <52F55511.2080309@mentor.com>
	<52FCCCD2.9050302@mentor.com>	<610029715.24333.1392300717731.JavaMail.zimbra@efficios.com>	<1692042945.24342.1392301795996.JavaMail.zimbra@efficios.com>	<1119459836.24348.1392302831554.JavaMail.zimbra@efficios.com>	<52FCE732.9090508@mentor.com>	<581364674.24417.1392309613306.JavaMail.zimbra@efficios.com>	<52FCF7F5.9070908@mentor.com>,
	<934762932.24558.1392317539645.JavaMail.zimbra@efficios.com>,
	<A30AF42E15BD64459E202697468DFFA77E387F33@EU-MBX-04.mgc.mentorg.com>
	<A30AF42E15BD64459E202697468DFFA77E389F61@EU-MBX-04.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Stefan_Seefeld@mentor.com>) id 1WE50q-0004Dw-0f
	for lttng-dev@lists.lttng.org; Thu, 13 Feb 2014 17:44:13 -0500
In-Reply-To: <A30AF42E15BD64459E202697468DFFA77E389F61@EU-MBX-04.mgc.mentorg.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Woegerer, Paul" <Paul_Woegerer@mentor.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Seefeld, Stefan" <Stefan_Seefeld@mentor.com>, lttng-dev <lttng-dev@lists.lttng.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: lttng-dev@lists.lttng.org

On 02/13/2014 05:06 PM, Woegerer, Paul wrote:
> Let me put it this way ...
>
> If (hypothetically, just for the sake of the argument) we would have dlsym with the following signature:
>
> void *dlsym(void *handle, const char *symbol, void *dummy);
>
> instead of:
>
> void *dlsym(void *handle, const char *symbol);
>
> and we would call it with:
>
> af.calloc = dlsym(RTLD_NEXT, "calloc", &cur_alloc);
>
> then (because of the aliasing of cur_alloc (caused by &cur_alloc) the compiler would be forced to store the effects done on cur_alloc into memory prior to calling dlsym.

Paul, I'm not convinced.

Our compilation unit defines a bunch of functions with external linkage,
which access cur_alloc. And since gcc has no way to rule out that the
call to dlsym() will not cause any of these functions to be called, it
mustn't make any assumptions about whether or not the first
initialization of cur_alloc is redundant or not, and thus shouldn't
elide it.

(The above is in fact quite a frequent idiom in C/C++ framework
libraries. Just imagine dlsym() being a call into a GUI (such as an
event loop), and the functions in this CU unit as callbacks.)

    Stefan

-- 
Stefan Seefeld
CodeSourcery / Mentor Graphics
http://www.mentor.com/embedded-software/
