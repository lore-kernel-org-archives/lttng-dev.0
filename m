From: Stefan Seefeld <stefan_seefeld@mentor.com>
Subject: Re: [PATCH lttng-ust] Add trace support for calloc and
 realloc.
Date: Wed, 7 Aug 2013 11:56:46 -0400
Message-ID: <52026E3E.9040806__36716.9002457105$1375891068$gmane$org@mentor.com>
References: <CA+jJMxtMH5Ajgoszg8pO8dq-KsrTg9NwS2YcYOz=FbLr0ijaEQ@mail.gmail.com>
	<alpine.LNX.2.00.1308012013380.9574@monopod.intra.ispras.ru>
	<51FA8DAE.3070409@mentor.com>
	<alpine.LNX.2.00.1308012045570.9574@monopod.intra.ispras.ru>
	<alpine.LNX.2.00.1308012115300.9574@monopod.intra.ispras.ru>
	<51FA9AD8.4010502@mentor.com>
	<CABtfrpDg_NOi+yP5GABmjBv6G9Zj+rvTwc1OdQ1s_9DM7uzeZg@mail.gmail.com>
	<20130803011841.GE9033@Krystal> <51FFC4DB.7080905@mentor.com>
	<52025E03.7090201@mentor.com> <20130807155057.GB1035@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Stefan_Seefeld@mentor.com>) id 1V766Y-0007eF-VV
	for lttng-dev@lists.lttng.org; Wed, 07 Aug 2013 11:57:00 -0400
Received: from svr-orw-exc-10.mgc.mentorg.com ([147.34.98.58])
	by relay1.mentorg.com with esmtp
	id 1V766T-0002eL-5n from Stefan_Seefeld@mentor.com
	for lttng-dev@lists.lttng.org; Wed, 07 Aug 2013 08:56:49 -0700
In-Reply-To: <20130807155057.GB1035@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On 08/07/2013 11:50 AM, Mathieu Desnoyers wrote:
> * Stefan Seefeld (stefan_seefeld@mentor.com) wrote:
>> ...and another revision of the previous patch, now with mutex-protected
>> static_calloc.
>> For consistency I have also adjusted the ust_libc.h header to use 'void
>> *' instead of 'unsigned long' in its tracepoint declaration.
> merged.

Thanks !

> I also pushed the following on top:
>
> commit 4c3536e01190b118e0889ebb991b0eea6f98260e
> Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Date:   Wed Aug 7 11:48:50 2013 -0400
>
>     malloc instrumentation: remove dependency on pthread
>     
>     Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>
> I notice that memalign and posix_memalign are missing. Do you have plans
> to add them ?

Yes, I can certainly do that.

    Stefan



-- 
Stefan Seefeld
CodeSourcery / Mentor Graphics
http://www.mentor.com/embedded-software/
