From: eamcs/eedbhu <Bernd.Hufmann@ericsson.com>
Subject: Re: LTTng Tools 2.1 streaming commands
Date: Fri, 5 Oct 2012 07:44:24 -0400
Message-ID: <506EC818.7050708__30181.5963969149$1349437508$gmane$org@ericsson.com>
References: <4CB817F8B8860343821834C09BFBA7A6E183805D4D@EUSAACMS0702.eamcs.ericsson.se>
	<506C837B.5070402@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from imr3.ericy.com ([198.24.6.13])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <bernd.hufmann@ericsson.com>) id 1TK6KY-0003Qr-Tg
	for lttng-dev@lists.lttng.org; Fri, 05 Oct 2012 07:44:35 -0400
In-Reply-To: <506C837B.5070402@efficios.com>
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

thanks for the detailed explanation.

I'm not debating the purpose of the command or that a 2 step approach is 
supported for enabling the consumer. As you described it makes sense to 
have this possibility.

However I'm debating mainly the name of the command "enable-consumer". 
The command suggests that the consumer will be enabled when executing 
the command. I foresee that a lot of users expect that the consumer is 
enabled after the command execution. I think, a different name would 
improve the user experience.

Best Regards
Bernd

On 10/03/2012 02:27 PM, David Goulet wrote:
> Hi Bernd,
>
> The enable-consumer, by default, always enable a consumer. We added the
> "extended options" such as the -U/-C/-D/-e to control each part of the
> API. So let say,
>
> $ lttng enable-consumer -k net://localhost
>
> This command does two API calls underneath which are
> lttng_set_consumer_uri and lttng_enable_consumer.
>
> However, the set_consumer_uri can be arbitrary long because it has to
> connect to the relayd (if remote) and set the session. It adds "unknown"
> latency to the command. So, for someone willing to control the full time
> window of the streaming setup using the API, it is divided in two calls.
>
> This is why we added the extended options so the command line UI could
> also be controlled on a per API call basis.
>
> Is it clear enough?
>
> Reply continues below:
>
> Bernd Hufmann:
>> Hello
>>
>> For the support of LTTng Tools 2.1 in Eclipse, I'm currently trying to
>> understand how to use the configuration for network streaming with the
>> updated "lttng create"-command and new "enable-consumer"-command.
>>
>> a) lttng enable-consumer
>> I find this command confusing because this command does not always
>> enables the consumer, even if the command name implieeees so. The enabling
>> actually depends on how the command is executed.
>> Examples:
>>
>>    * "lttng enable-consumer -k -U net://<remote_addr>" or "lttng
>>      enable-consumer -k -C tcp://<remote_addr>  -D tcp://<remote_addr>"
>>      don't enable the consumer. You need to either add option --enable or
>>      execute subsequently "lttng enable-consumer --enable"
>>    * lttng enable-consumer -k net://<remote_addr>  does enable the
>>      consumer. I took me a while to figure out the difference to the
>>      example above: The option -U is omitted.
>>
>>
>> What the command actually provides, is 2 features: A way to configure
>> streaming (e.g. remote_addr) and a way to enable the consumer. Would it
>> be better to name it to "lttng configure-consumer"? Also, remove the
>> support of the possibility to not specify -U, -C or -D. The following
>> variants of this command should be enough:
>> lttng configure-consumer -k -U<remote_addr>  [--enable]
>> lttng configure-consumer -k -C<remote_addr>  -D<remote_addr>  [--enable]
>> lttng configure-consumer -k --enable
>> lttng configure-consumer -u -U<remote_addr>  [--enable]
>> lttng configure-consumer -u -C<remote_addr>  -D<remote_addr>  [--enable]
>> lttng configure-consumer -u --enable
>>
>> Please let me know what you think.
>>
>> b) lttng create [-U<remote_addr>] | [-C<remote_addr>  -D<remote_addr>]
>> [--no-consumer] [--disable-consumer]
>>
>>    * Are options --no-consumer or --disable-consumer only applicable for
>>      streaming?
> No, also for local consumer.
>
>>    * I'm not sure what is the purpose of the options --no-consumer or
>>      --disable-consumer. Could you please explain the use cases for using
>>      --no-consumer or --disable-consumer?
> This basically disable the consumer for a tracing session. It's not very
> useful for now but for upcoming snapshots and live tracing, it will make
> way more sense! :).
>
> Again, same idea, the API can control the consumer "state"
> (enable/disable), so we added these options for the UI.
>
> Cheers!
> David
>
>>
>> Thanks
>> Bernd
>>
>> This Communication is Confidential. We only send and receive email on
>> the basis of the terms set out at _www.ericsson.com/email_disclaimer_
>>
>>
>>
>>
>> This body part will be downloaded on demand.
