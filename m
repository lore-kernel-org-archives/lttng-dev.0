From: John Steele Scott <toojays@toojays.net>
Subject: Re: urcu commit a767fd requires autoconf >= 2.64.
Date: Wed, 13 Jun 2012 22:41:57 +0930
Message-ID: <4FD8919D.9060607__10059.5898148187$1339595021$gmane$org@toojays.net>
References: <jr9e2h$phq$1@dough.gmane.org> <20120613081001.GA30123@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pz0-f51.google.com ([209.85.210.51])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <toojays@toojays.net>) id 1SenMm-0003vo-0l
	for lttng-dev@lists.lttng.org; Wed, 13 Jun 2012 09:12:08 -0400
Received: by dajt11 with SMTP id t11so1019690daj.38
	for <lttng-dev@lists.lttng.org>; Wed, 13 Jun 2012 06:12:01 -0700 (PDT)
In-Reply-To: <20120613081001.GA30123@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On 13/06/12 17:40, Mathieu Desnoyers wrote:
> * John Steele Scott (toojays@toojays.net) wrote:
>> http://lists.lttng.org/pipermail/lttng-dev/2012-May/017927.html
>>
>> I tried to build the latest urcu (git master e51500) on a Centos 6.2 box, and got:
>>
>> jscott@dxi0-62:~/src/userspace-rcu$ make -j4
>> CDPATH="${ZSH_VERSION+.}:" && cd . && /bin/sh /users/jscott/src/userspace-rcu/config/missing --run aclocal-1.11 -I config
>> CDPATH="${ZSH_VERSION+.}:" && cd . && /bin/sh /users/jscott/src/userspace-rcu/config/missing --run autoconf
>>  cd . && /bin/sh /users/jscott/src/userspace-rcu/config/missing --run automake-1.11 --foreign
>> configure:4010: error: possibly undefined macro: m4_ifnblank
>>       If this token and others are legitimate, please use m4_pattern_allow.
>>       See the Autoconf documentation.
>> make: *** [configure] Error 1
>> make: *** Waiting for unfinished jobs....
>>
>> Some digging showed that the macro m4_ifnblank requires autoconf 2.64. Centos 6.2 has autoconf 2.63. :(
>>
>> I just worked around it by reverting commit a767fd locally, then I can build fine.
> Thanks for pointing this out! Can you try the following patch and let me
> know if it fixes your issue ?
>
>

Mathieu,

Thanks for your quick response. Unfortunately, with that patch, ./configure fails like:

checking for thread local storage (TLS) class... __thread
./configure: line 4029: syntax error near unexpected token `fi'
./configure: line 4029: `fi'

The section of configure which it's complaining about looks like:

 if test "$ac_cv_tls" != "none"; then

     cat >>confdefs.h <<_ACEOF                                                                                                                                                                                    
#define TLS $ac_cv_tls                                                                                                                                                                                            
_ACEOF                                                                                                                                                                                                            

     cat >>confdefs.h <<_ACEOF                                                                                                                                                                                    
#define CONFIG_RCU_TLS $ac_cv_tls                                                                                                                                                                                 
_ACEOF                                                                                                                                                                                                            

 else

 fi

It seems it doesn't like the empty else..fi clause. If I put a command in there ("true", "echo", whatever), configure completes and I can build successfully.

cheers,

John
