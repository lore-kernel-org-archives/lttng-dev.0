From: Bernd Hufmann <bernd.hufmann@ericsson.com>
Subject: Re: LTTng Tools 2.1 streaming commands
Date: Wed, 10 Oct 2012 09:20:41 -0400
Message-ID: <4CB817F8B8860343821834C09BFBA7A6E272920175__1467.76719852841$1349875293$gmane$org@EUSAACMS0702.eamcs.ericsson.se>
References: <4CB817F8B8860343821834C09BFBA7A6E183805D4D@EUSAACMS0702.eamcs.ericsson.se>
	<50747625.2010109@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from imr4.ericy.com ([198.24.6.9])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <bernd.hufmann@ericsson.com>) id 1TLwDW-0003cO-SC
	for lttng-dev@lists.lttng.org; Wed, 10 Oct 2012 09:20:55 -0400
In-Reply-To: <50747625.2010109@efficios.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David Goulet <dgoulet@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

 
Hi David

Thanks for looking into this.

Bernd

This Communication is Confidential. We only send and receive email on the basis of the terms set out at www.ericsson.com/email_disclaimer

-----Original Message-----
From: David Goulet [mailto:dgoulet@efficios.com] 
Sent: October-09-12 3:08 PM
To: Bernd Hufmann
Cc: lttng-dev@lists.lttng.org
Subject: Re: [lttng-dev] LTTng Tools 2.1 streaming commands

After talking a bit about this issue with other LTTng devs, it turns out that it makes more sense to have a "set-consumer" command and remove enable/disable-consumer from the cmd UI.

I'll send a proposal on lttng-dev in the next days and please, everyone, feel free to give feedbacks on this.

Thanks!
David

Bernd Hufmann:
> Hello
>  
> For the support of LTTng Tools 2.1 in Eclipse, I'm currently trying to 
> understand how to use the configuration for network streaming with the 
> updated "lttng create"-command and new "enable-consumer"-command.
>  
> a) lttng enable-consumer
> I find this command confusing because this command does not always 
> enables the consumer, even if the command name implies so. The 
> enabling actually depends on how the command is executed.
> Examples:
> 
>   * "lttng enable-consumer -k -U net://<remote_addr>" or "lttng
>     enable-consumer -k -C tcp://<remote_addr> -D tcp://<remote_addr>"
>     don't enable the consumer. You need to either add option --enable or
>     execute subsequently "lttng enable-consumer --enable"
>   * lttng enable-consumer -k net://<remote_addr> does enable the
>     consumer. I took me a while to figure out the difference to the
>     example above: The option -U is omitted.
> 
>  
> What the command actually provides, is 2 features: A way to configure 
> streaming (e.g. remote_addr) and a way to enable the consumer. Would 
> it be better to name it to "lttng configure-consumer"? Also, remove 
> the support of the possibility to not specify -U, -C or -D. The 
> following variants of this command should be enough:
> lttng configure-consumer -k -U <remote_addr> [--enable] lttng 
> configure-consumer -k -C <remote_addr> -D <remote_addr> [--enable] 
> lttng configure-consumer -k --enable lttng configure-consumer -u -U 
> <remote_addr> [--enable] lttng configure-consumer -u -C <remote_addr> 
> -D <remote_addr> [--enable] lttng configure-consumer -u --enable
>  
> Please let me know what you think.
>  
> b) lttng create [-U <remote_addr>] | [-C <remote_addr> -D 
> <remote_addr>] [--no-consumer] [--disable-consumer]
> 
>   * Are options --no-consumer or --disable-consumer only applicable for
>     streaming?
>   * I'm not sure what is the purpose of the options --no-consumer or
>     --disable-consumer. Could you please explain the use cases for using
>     --no-consumer or --disable-consumer? 
> 
>  
> Thanks
> Bernd
>  
> This Communication is Confidential. We only send and receive email on 
> the basis of the terms set out at _www.ericsson.com/email_disclaimer_
>  
>  
> 
> 
> This body part will be downloaded on demand.
