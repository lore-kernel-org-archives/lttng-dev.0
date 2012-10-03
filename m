From: David Goulet <dgoulet@efficios.com>
Subject: Re: LTTng Tools 2.1 streaming commands
Date: Wed, 03 Oct 2012 14:27:07 -0400
Message-ID: <506C837B.5070402__45702.5442309261$1349288893$gmane$org@efficios.com>
References: <4CB817F8B8860343821834C09BFBA7A6E183805D4D@EUSAACMS0702.eamcs.ericsson.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1TJTf4-000813-GJ
	for lttng-dev@lists.lttng.org; Wed, 03 Oct 2012 14:27:10 -0400
In-Reply-To: <4CB817F8B8860343821834C09BFBA7A6E183805D4D@EUSAACMS0702.eamcs.ericsson.se>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Bernd Hufmann <bernd.hufmann@ericsson.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi Bernd,

The enable-consumer, by default, always enable a consumer. We added the
"extended options" such as the -U/-C/-D/-e to control each part of the
API. So let say,

$ lttng enable-consumer -k net://localhost

This command does two API calls underneath which are
lttng_set_consumer_uri and lttng_enable_consumer.

However, the set_consumer_uri can be arbitrary long because it has to
connect to the relayd (if remote) and set the session. It adds "unknown"
latency to the command. So, for someone willing to control the full time
window of the streaming setup using the API, it is divided in two calls.

This is why we added the extended options so the command line UI could
also be controlled on a per API call basis.

Is it clear enough?

Reply continues below:

Bernd Hufmann:
> Hello
>  
> For the support of LTTng Tools 2.1 in Eclipse, I'm currently trying to
> understand how to use the configuration for network streaming with the
> updated "lttng create"-command and new "enable-consumer"-command.
>  
> a) lttng enable-consumer
> I find this command confusing because this command does not always
> enables the consumer, even if the command name implieeees so. The enabling
> actually depends on how the command is executed.
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
> streaming (e.g. remote_addr) and a way to enable the consumer. Would it
> be better to name it to "lttng configure-consumer"? Also, remove the
> support of the possibility to not specify -U, -C or -D. The following
> variants of this command should be enough:
> lttng configure-consumer -k -U <remote_addr> [--enable]
> lttng configure-consumer -k -C <remote_addr> -D <remote_addr> [--enable]
> lttng configure-consumer -k --enable
> lttng configure-consumer -u -U <remote_addr> [--enable]
> lttng configure-consumer -u -C <remote_addr> -D <remote_addr> [--enable]
> lttng configure-consumer -u --enable
>  
> Please let me know what you think.
>  
> b) lttng create [-U <remote_addr>] | [-C <remote_addr> -D <remote_addr>]
> [--no-consumer] [--disable-consumer]
> 
>   * Are options --no-consumer or --disable-consumer only applicable for
>     streaming?

No, also for local consumer.

>   * I'm not sure what is the purpose of the options --no-consumer or
>     --disable-consumer. Could you please explain the use cases for using
>     --no-consumer or --disable-consumer? 

This basically disable the consumer for a tracing session. It's not very
useful for now but for upcoming snapshots and live tracing, it will make
way more sense! :).

Again, same idea, the API can control the consumer "state"
(enable/disable), so we added these options for the UI.

Cheers!
David

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
