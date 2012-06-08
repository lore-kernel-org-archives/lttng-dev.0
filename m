From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Lttng start failed
Date: Fri, 8 Jun 2012 13:42:26 -0400
Message-ID: <20120608174226.GA23339__40773.8109039657$1339177377$gmane$org@Krystal>
References: <47D610AD9C485E458630BA38C324D3B60113FB00F9EA@EXGMBX01.sasken.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1Sd3Cf-0002XD-KL
	for lttng-dev@lists.lttng.org; Fri, 08 Jun 2012 13:42:29 -0400
Content-Disposition: inline
In-Reply-To: <47D610AD9C485E458630BA38C324D3B60113FB00F9EA@EXGMBX01.sasken.com>
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
> Hi ,
> 
> I am new to LTTng usage, I am trying to use LTTng 2.0.1 and LTTng-modules-2.0.2  for ARM(omapL138), with Linux kernel 2.6.33 wit RT-29 patch on it.
> 
> After enabling all the kernel events I am facing the below errors. I loaded all the modules manually by insmod.
> 
> 
> 
> root@arago:~/lttng-traces# arm-none-linux-gnueabi-lttng create newsessiom
> Session newsessiom created.
> Traces will be written in /home/root/lttng-traces/newsessiom-20110325-154922
> 
> root@arago:~/lttng-traces# arm-none-linux-gnueabi-lttng enable-event -a --kernel
> All kernel events are enabled in channel channel0
> 
> root@arago:~/lttng-traces# arm-none-linux-gnueabi-lttng start
> LTTng: Failure to write metadata to buffers (timeout)
> Error: Starting kernel trace failed
> 
> Please kindly help me on this.

I think you should look into the lttng-sessiond --help :

      --consumerd32-path PATH     Specify path for the 32-bit UST consumer daemon binary
      --consumerd32-libdir PATH   Specify path for the 32-bit UST consumer daemon libraries
      --consumerd64-path PATH     Specify path for the 64-bit UST consumer daemon binary
      --consumerd64-libdir PATH   Specify path for the 64-bit UST consumer daemon libraries

options. My guess is that lttng-sessiond is not able to find the
consumerd binary files, maybe due to a rename or because they have been
moved after install.

One more thing that might help is to launch the lttng-sessiond with
"-vvv" : it will provide verbose output and let us know where things
fall apart.

Thanks,

Mathieu


> 
> 
> Thanks in advance,
> Pavan
> 
> ________________________________
> SASKEN BUSINESS DISCLAIMER: This message may contain confidential, proprietary or legally privileged information. In case you are not the original intended Recipient of the message, you must not, directly or indirectly, use, disclose, distribute, print, or copy any part of this message and you are requested to delete it and inform the sender. Any views expressed in this message are those of the individual sender unless otherwise stated. Nothing contained in this message shall be construed as an offer or acceptance of any offer by Sasken Communication Technologies Limited ("Sasken") unless sent with that express intent and with due authority of Sasken. Sasken has taken enough precautions to prevent the spread of viruses. However the company accepts no liability for any damage caused by an
 y virus transmitted by this email.
> Read Disclaimer at http://www.sasken.com/extras/mail_disclaimer.html

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
