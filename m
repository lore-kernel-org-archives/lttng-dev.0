From: Stefan Seefeld <stefan@seefeld.name>
Subject: Re: [PATCH lttng-ust] Add trace support for calloc and
 realloc.
Date: Wed, 07 Aug 2013 09:37:12 -0400
Message-ID: <52024D88.8090409__5877.45636371455$1375882700$gmane$org@seefeld.name>
References: <51F82C45.6020502@mentor.com>
	<CA+jJMxtMH5Ajgoszg8pO8dq-KsrTg9NwS2YcYOz=FbLr0ijaEQ@mail.gmail.com>
	<alpine.LNX.2.00.1308012013380.9574@monopod.intra.ispras.ru>
	<51FA8DAE.3070409@mentor.com>
	<alpine.LNX.2.00.1308012045570.9574@monopod.intra.ispras.ru>
	<alpine.LNX.2.00.1308012115300.9574@monopod.intra.ispras.ru>
	<51FA9AD8.4010502@mentor.com>
	<CABtfrpDg_NOi+yP5GABmjBv6G9Zj+rvTwc1OdQ1s_9DM7uzeZg@mail.gmail.com>
	<20130803011841.GE9033@Krystal> <51FFBD46.5030105@mentor.com>
	<20130807014241.GH19407@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pb0-f53.google.com ([209.85.160.53])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <stefan.seefeld@gmail.com>) id 1V73vV-0008Dg-QR
	for lttng-dev@lists.lttng.org; Wed, 07 Aug 2013 09:37:27 -0400
Received: by mail-pb0-f53.google.com with SMTP id up15so1880620pbc.40
	for <lttng-dev@lists.lttng.org>; Wed, 07 Aug 2013 06:37:16 -0700 (PDT)
Received: from [192.168.2.10] (bas2-montreal29-1279583707.dsl.bell.ca.
	[76.68.229.219])
	by mx.google.com with ESMTPSA id x8sm8281857pbb.39.2013.08.07.06.37.13
	for <lttng-dev@lists.lttng.org>
	(version=TLSv1 cipher=RC4-SHA bits=128/128);
	Wed, 07 Aug 2013 06:37:14 -0700 (PDT)
In-Reply-To: <20130807014241.GH19407@Krystal>
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

On 08/06/2013 09:42 PM, Mathieu Desnoyers wrote:
> * Stefan Seefeld (stefan_seefeld@mentor.com) wrote:
>> Yes, with the adjusted free() implementation as per this patch, I think
>> this is a robust solution. Do you think we need any form of multi-thread
>> protection ? Or can we assume that library initialization will have
>> completed by the time multiple threads could possibly call calloc() ?
> Well, considering that lttng-ust spawns thread in its constructor, it
> might indeed be a good thing to be thread-safe. Fixed by:
>
> commit d9e6d9a57fda6d3ad73016b2b3137997aac9c7ba
> Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Date:   Tue Aug 6 21:41:15 2013 -0400
>
>     Fix: static_calloc should be thread-safe
>     
>     Reported-by: Stefan Seefeld <stefan_seefeld@mentor.com>
>     Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>
> Thoughts ?

Sorry, I'm confused. Where can I find this commit, i.e. what repo, what
branch ? I can't see it anywhere ?

Thanks,
        Stefan

-- 

      ...ich hab' noch einen Koffer in Berlin...
