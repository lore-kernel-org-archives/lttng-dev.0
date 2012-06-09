From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Lttng start failed
Date: Sat, 9 Jun 2012 08:32:52 -0400
Message-ID: <20120609123251.GA14280__32239.0248919421$1339245204$gmane$org@Krystal>
References: <47D610AD9C485E458630BA38C324D3B60113FB00F9EA@EXGMBX01.sasken.com>
	<20120608174226.GA23339@Krystal>
	<47D610AD9C485E458630BA38C324D3B60113FB00FA00@EXGMBX01.sasken.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1SdKqc-0002VS-Ei
	for lttng-dev@lists.lttng.org; Sat, 09 Jun 2012 08:32:54 -0400
Content-Disposition: inline
In-Reply-To: <47D610AD9C485E458630BA38C324D3B60113FB00FA00@EXGMBX01.sasken.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Pavan Anumula <pavan.anumula@sasken.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

* Pavan Anumula (pavan.anumula@sasken.com) wrote:
> Hi Mathue,
> 
> Thanks for the quick reply,
> 
> After inserting lttng modules , I had given the command  "arm-none-linux-gnueabi-lttng-sessiond -vvv"  as you said, Below is the output where there are error messages. Please help me in resolving the issue, SO that I can catch kernel and user traces.
> 
> 
> root@arago:/usr/lttng/modules# arm-none-linux-gnueabi-lttng-sessiond -d
> root@arago:/usr/lttng/modules# arm-none-linux-gnueabi-lttng-sessiond -vvv
> DEBUG3: Creating LTTng run directory: /var/run/lttng [in create_lttng_rundir() at main.c:4315]
> DEBUG2: Kernel consumer err path: /var/run/lttng/kconsumerd/error [in main() at main.c:4543]
> DEBUG2: Kernel consumer cmd path: /var/run/lttng/kconsumerd/command [in main() at main.c:4545]
> DEBUG1: Client socket path /var/run/lttng/client-lttng-sessiond [in main() at main.c:4592]
> DEBUG1: Application socket path /var/run/lttng/apps-lttng-sessiond [in main() at main.c:4593]
> DEBUG1: LTTng run directory path: /var/run/lttng [in main() at main.c:4594]
> DEBUG2: UST consumer 32 bits err path: /var/run/lttng/ustconsumerd32/error [in main() at main.c:4603]
> DEBUG2: UST consumer 32 bits cmd path: /var/run/lttng/ustconsumerd32/command [in main() at main.c:4605]
> DEBUG2: UST consumer 64 bits err path: /var/run/lttng/ustconsumerd64/error [in main() at main.c:4614]
> DEBUG2: UST consumer 64 bits cmd path: /var/run/lttng/ustconsumerd64/command [in main() at main.c:4616]
> Error: Already running daemon.

Please kill the lttng-sessiond that is already started (the one with
-d). Instead of that one, run the sessiond with:

lttng-sessiond -vvv

(don't run lttng-sessiond -d before)

Thanks,

Mathieu

> 
> 
> 
> 
> Thanks in advance,
> Pavan
> 
> -----Original Message-----
> From: Mathieu Desnoyers [mailto:mathieu.desnoyers@efficios.com] 
> Sent: Friday, June 08, 2012 11:12 PM
> To: Pavan Anumula
> Cc: lttng-dev@lists.lttng.org
> Subject: Re: [lttng-dev] Lttng start failed
> 
> * Pavan Anumula (pavan.anumula@sasken.com) wrote:
> > Hi ,
> > 
> > I am new to LTTng usage, I am trying to use LTTng 2.0.1 and LTTng-modules-2.0.2  for ARM(omapL138), with Linux kernel 2.6.33 wit RT-29 patch on it.
> > 
> > After enabling all the kernel events I am facing the below errors. I loaded all the modules manually by insmod.
> > 
> > 
> > 
> > root@arago:~/lttng-traces# arm-none-linux-gnueabi-lttng create 
> > newsessiom Session newsessiom created.
> > Traces will be written in 
> > /home/root/lttng-traces/newsessiom-20110325-154922
> > 
> > root@arago:~/lttng-traces# arm-none-linux-gnueabi-lttng enable-event 
> > -a --kernel All kernel events are enabled in channel channel0
> > 
> > root@arago:~/lttng-traces# arm-none-linux-gnueabi-lttng start
> > LTTng: Failure to write metadata to buffers (timeout)
> > Error: Starting kernel trace failed
> > 
> > Please kindly help me on this.
> 
> I think you should look into the lttng-sessiond --help :
> 
>       --consumerd32-path PATH     Specify path for the 32-bit UST consumer daemon binary
>       --consumerd32-libdir PATH   Specify path for the 32-bit UST consumer daemon libraries
>       --consumerd64-path PATH     Specify path for the 64-bit UST consumer daemon binary
>       --consumerd64-libdir PATH   Specify path for the 64-bit UST consumer daemon libraries
> 
> options. My guess is that lttng-sessiond is not able to find the consumerd binary files, maybe due to a rename or because they have been moved after install.
> 
> One more thing that might help is to launch the lttng-sessiond with "-vvv" : it will provide verbose output and let us know where things fall apart.
> 
> Thanks,
> 
> Mathieu
> 
> 
> > 
> > 
> > Thanks in advance,
> > Pavan
> > 
> > ________________________________
> > SASKEN BUSINESS DISCLAIMER: This message may contain confidential, proprietary or legally privileged information. In case you are not the original intended Recipient of the message, you must not, directly or indirectly, use, disclose, distribute, print, or copy any part of this message and you are requested to delete it and inform the sender. Any views expressed in this message are those of the individual sender unless otherwise stated. Nothing contained in this message shall be construed as an offer or acceptance of any offer by Sasken Communication Technologies Limited ("Sasken") unless sent with that express intent and with due authority of Sasken. Sasken has taken enough precautions to prevent the spread of viruses. However the company accepts no liability for any damage caused by 
 any virus transmitted by this email.
> > Read Disclaimer at http://www.sasken.com/extras/mail_disclaimer.html
> 
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 
> 
> --
> Mathieu Desnoyers
> Operating System Efficiency R&D Consultant EfficiOS Inc.
> http://www.efficios.com

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
