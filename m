From: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Subject: Re: liblttng-ust-cyg-profile.so not found
Date: Tue, 28 Jan 2014 12:45:34 -0500
Message-ID: <52E7ECBE.8050300__4369.86444187841$1390931201$gmane$org@voxpopuli.im>
References: <CAKQh6pgjuidy=KzKNQx1hropC_A8Nvdsk4AX2S0j2CHXCP8ihw@mail.gmail.com>	<1390930183.52e7e90758145@www.imp.polymtl.ca>
	<CAKQh6pgwetoHcw3fxRHqHcvEZOVcYFmia_xivgAH+YPO3ZxzkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <alexmonthy@voxpopuli.im>) id 1W8CjG-0004Wt-AR
	for lttng-dev@lists.lttng.org; Tue, 28 Jan 2014 12:45:48 -0500
In-Reply-To: <CAKQh6pgwetoHcw3fxRHqHcvEZOVcYFmia_xivgAH+YPO3ZxzkA@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Shariyar <syed.shariyar@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On Ubuntu/Debian, there is no "lib64", it's /usr/lib/x86_64-linux-gnu/

If you installed UST from the distro package, it should be at:
/usr/lib/x86_64-linux-gnu/liblttng-ust-cyg-profile.so.0

(the .so symlink is only installed by the -dev package)

If you installed from source, it would be at:
/usr/local/lib/liblttng-ust-cyg-profile.so


Quick tip: you can use:
 dpkg -L liblttng-ust0
to list the files installed by a package.


Cheers,
Alexandre


On 14-01-28 12:32 PM, Shariyar wrote:
> It is not present in the system even after reinstalling ust libs from PPA.
> I am working on Ubuntu 12.04.1 LTS, 64 bit.
>
> Regards,
> Shariyar
>
>
> On Tue, Jan 28, 2014 at 12:29 PM, Suchakrapani Datt Sharma <
> suchakrapani.sharma@polymtl.ca> wrote:
>
>> Check if the liblttng-ust-cyg-profile.so is present in system using
>> 'locate'. On
>> my system its in /usr/lib64
>>
>> Then give the absolute path -
>>
>> *LD_PRELOAD=/usr/lib64/liblttng-ust-cyg-profile.so* appname
>>
>> This works for me.
>>
>> --
>> Suchakra
>>
>> Quoting Shariyar <syed.shariyar@gmail.com>:
>>
>>> Hi,
>>>
>>> I am trying to collect function entry and exit points in a trace. I  have
>>> followed the instructions written on the following man page:
>>>
>> http://manpages.ubuntu.com/manpages/trusty/man3/lttng-ust-cyg-profile.3.html
>> .
>>>
>>> In my system, UST tracepoint tracing  is working fine and I am able to
>>> collect traces with the statically typed tracepoints in the code.
>> However,
>>> there is no liblttng-ust-cyg-profile.so in my system and I get an error
>>> when I execute the following:
>>>
>>>        *LD_PRELOAD=liblttng-ust-cyg-profile.so* appname
>>>
>>> Please let me know how to get it to work?
>>>
>>> Thanks,
>>> Shariyar
>>>
>>
>>
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
