From: David Goulet <david.goulet@polymtl.ca>
Subject: Re: [RELEASE] LTTng-tools 2.1.0-rc1
Date: Wed, 22 Aug 2012 11:57:01 -0400
Message-ID: <5035014D.1080701__40645.7815705382$1345651049$gmane$org@polymtl.ca>
References: <502EA58E.2060003@efficios.com> <5034D4BE.7060400@ericsson.com>
	<5034DD32.1010309@efficios.com> <5034EC6B.7010206@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <david.goulet@polymtl.ca>) id 1T4DIm-0000Pb-By
	for lttng-dev@lists.lttng.org; Wed, 22 Aug 2012 11:57:04 -0400
In-Reply-To: <5034EC6B.7010206@ericsson.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Bernd Hufmann <Bernd.Hufmann@ericsson.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, David Goulet <dgoulet@efficios.com>
List-Id: lttng-dev@lists.lttng.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



On 22/08/12 10:27 AM, Bernd Hufmann wrote:
> Hi David
> 
> thanks for your answers. See below for more information.
> 
> \Bernd
> 
> On 08/22/2012 09:22 AM, David Goulet wrote: Hi Bernd,
> 
> Comments below.
> 
> Bernd Hufmann:
>>>> Hi David
>>>> 
>>>> I've just installed LTTng-tools 2.1.0-rc1 and I wanted to use it with
>>>> the Eclipse LTTng tracer control. First, I added 2.1.x as supported
>>>> version to Eclipse and then I tried to used it with 2.0.x features. I
>>>> noticed a few differences in the output strings of command outputs
>>>> [1] as well as the directory structure of generated traces [2]. The
>>>> Eclipse LTTng tracer control parses the String output of the commands
>>>> to extract relevant information.
>>>> 
>>>> Generally, it would be much easier to maintain the Eclipse LTTng 
>>>> tracer control if for existing features the string outputs and the 
>>>> directory structure are the same as before. Please note, if someone 
>>>> uses scripts to generate traces the output format is also important.
>>>> 
>>>> [1] Command output of lttng create mysession: In v2.0.x the output 
>>>> was: Session mysession created. Traces will be written in 
>>>> /home/user/lttng-traces/mysession-20120314-132824
>>>> 
>>>> in v2.1.x the output is: Trace(s) output set to 
>>>> /home/user/lttng-traces/mysession-20120822-082243 Session mysession 
>>>> created.
>>>> 
>>>> So, the first and second line are swapped. Also the content of the 
>>>> line with the path is changed. Would it be possible, to have the same
>>>> order of the lines and same output as in v2.0.x?
> Hmmmm, that's a fair point. Normally I would *strongly* recommand you use
> "lttng list mysession" to get the output path but still, we could make the
> argument that the output of the "create" command should not changed between
> minor version.
>> I use the list command to get the directory of a session and the session
>> name. However, there are some validation done after "lttng create
>> session" (e.g. check for correct session name or path). So the order of
>> lines and string content is important. I already use regular expressions
>> to problems with minor changes (e.g. more whitespaces), but we cannot
>> foresee all cases.
> 
>> As I understand the numbering scheme, the first digit is for major
>> changes (non-backwards compatible, API breaking changes). The second
>> digit is for non-API breaking changes including feature and API
>> additions. And the last digit (minor) is for bugfixes. Since there is no
>> remote protocol defined for using LTTng tools remotely, the Eclipse LTTng
>> control relies on the string output of the command line tool. So, I
>> consider the output as part of the API :-).

I will have to agree on that and will change back the output. I'll make a RC2
after that.

> 
>>>> [2] Trace directory structure: I noticed that the UST traces are 
>>>> moved under another sub-directory.
>>>> 
>>>> In v2.0.x the directory structure looked as follows: 
>>>> /home/user/lttng-traces/ |-mysession-20120314-132824 |-kernel 
>>>> |---<kernel trace files>  |-ust |---<programA-<PID>-<date>> 
>>>> |-----------<program A specific trace files>
>>>> 
>>>> In v2.1.x the directory structure looked as follows: 
>>>> /home/user/lttng-traces/ |-mysession-20120314-132824 |-kernel 
>>>> |---<kernel trace files>  |-ust |--- mysession-20120314-132824 
>>>> |---<programA-<PID>-<date>>  |-----------<program A specific trace 
>>>> files>
> This is absolutely not suppose to be like that... I'm unable to reproduce
> this behavior having the "mysession-**" created two times.
> 
> Can you give me the exact series of command you do to get this directory
> structure?
>> See below the log of commands I executed. I also added the output of
>> command "find ." under lttng-traces directory. In there you see the
>> additional sub-directory. By the way, I installed lttng-tools, lttng-ust
>> and userspace-rcu from source code.  Here are the corresponding SHA
>> numbers: lttng-tools: 68264071f9d1b789de1350cbec479b52a9b54acf lttng-ust:
>> 0f4eaec3e738fa0f33296a46fe08266a60787c23 userspace-rcu:
>> 768fba83676f49eb73fd1d8ad452016a84c5ec2a
> 
> 
> lttng create mysession
>> Trace(s) output set to
>> /home/bernd/lttng-traces/mysession-20120822-094418 Session mysession
>> created.
> 
> lttng enable-event  -a  -k
>> All kernel events are enabled in channel channel0
> 
> lttng enable-event  -a  -u
>> All UST events are enabled in channel channel0
> 
> lttng start
>> Tracing started for session mysession
> 
> lttng stop
>> Tracing stopped for session mysession
> 
> lttng destroy
>> Session mysession destroyed
> 
> find .
>> . ./mysession-20120822-094418 
>> ./mysession-20120822-094418/mysession-20120822-094542 
>> ./mysession-20120822-094418/mysession-20120822-094542/ust 
>> ./mysession-20120822-094418/mysession-20120822-094542/ust/lt-hello-2039-20120822-094551
>
>>  
>> ./mysession-20120822-094418/mysession-20120822-094542/ust/lt-hello-2039-20120822-094551/channel0_0
>
>>  
>> ./mysession-20120822-094418/mysession-20120822-094542/ust/lt-hello-2039-20120822-094551/metadata
>
>>  
>> ./mysession-20120822-094418/mysession-20120822-094542/ust/lt-hello-2056-20120822-094551
>
>>  
>> ./mysession-20120822-094418/mysession-20120822-094542/ust/lt-hello-2056-20120822-094551/channel0_0
>
>>  
>> ./mysession-20120822-094418/mysession-20120822-094542/ust/lt-hello-2056-20120822-094551/metadata
>
>>  ./mysession-20120822-094418/kernel 
>> ./mysession-20120822-094418/kernel/channel0_0 
>> ./mysession-20120822-094418/kernel/metadata

There is a bug. I'll push a patch before RC2.

A wrong pointer was used during the directory setting having the wrong
behavior you are witnessing :). Good catch and thanks for the report!

Cheers
David

> 
> The normal case and wht 2.1.x should to is provide you the same directory
> structure as 2.0.x. Ex:
> 
> ~/lttng-traces/test-20120822-091412/ust/lt-hello-4542-20120822-091415
> 
> Thanks! David
> 
>>>> So as you see, under ust there is another sub directory with trace 
>>>> session name and date/time. I don't see a practical reason to have 
>>>> this sub directory, because the session name and date/time is already
>>>> known from the top-level directory. Is it possible to revert this
>>>> back? In Eclipse I would have to implement a special case for
>>>> different LTTng-tools versions (in the import dialog).
>>>> 
>>>> Thank you very much in advance.
>>>> 
>>>> Best Regards Bernd
>>>> 
>>>> 
>>>> On 08/17/2012 04:11 PM, David Goulet wrote: Greetings everyone 
>>>> (including LTTng elves),
>>>> 
>>>> The lttng-tools project provides a session daemon (lttng-sessiond) 
>>>> that acts as a tracing registry, the "lttng" command line for tracing
>>>> control, a lttng-ctl library for tracing control and a lttng-relayd
>>>> for network streaming.
>>>> 
>>>> This is the first release candidate for lttng-tools 2.1 which brings
>>>> two exciting new features, network streaming and filtering support.
>>>> 
>>>> It's the combination of a lot of work from the LTTng team so please,
>>>> to help us improve our tools, report any bugs or misbehaving
>>>> feature(s) that you may encounter through this mailing list or the
>>>> bug tracker (https://bugs.lttng.org).
>>>> 
>>>> - From now on, lttng-tools is in feature freeze mode unless an 
>>>> *IMMENSE* show stopper is found.
>>>> 
>>>> 2012-08-17 lttng-tools 2.1.0-rc1 * Feature: Network Streaming * Add 
>>>> the lttng-relayd binary for network streaming * Support user space 
>>>> tracer filtering * Multiple fixes
>>>> 
>>>> Project website: http://lttng.org/lttng2.0 Download link: 
>>>> http://lttng.org/files/lttng-tools/lttng-tools-2.1.0-rc1.tar.bz2
>>>> 
>>>> Cheers! David
>>>>> _______________________________________________ lttng-dev mailing 
>>>>> list lttng-dev@lists.lttng.org 
>>>>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>>> 
>>>> _______________________________________________ lttng-dev mailing 
>>>> list lttng-dev@lists.lttng.org 
>>>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 
> 
> _______________________________________________ lttng-dev mailing list 
> lttng-dev@lists.lttng.org 
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAEBAgAGBQJQNQFJAAoJEELoaioR9I02XnEH/AlGnn2oryRAA5FWihIt+gcN
5Mk4Ry/6iCCeIvFBwqtZpG+ATG8hBBouzAopjfRMs0tzZSVxs4Nq+jLJchTD8Igh
mPJyXhorBo4nCXFsH1FVaduQzTwos8hxsH2htpS6YU3DJhR4kLaVR8Qnk1Gt6t9q
HoeoXFGwaP51NHrL9m4pMvdrlUTBOFkYYTeBLrUPV/ikmkhXwmSsnQZzGsFCMphE
Qb9jEr1QebvyEk7CAocaKUMjh37j+qpaLQeOUYch6YdK+kuurotqgWqMWi/9a+UF
F+/I5wvParmN6VyWcEfo4fUqlP/4x09x1tbOyyjYf/EQ8v5PKfO7gp62xV1QRzM=
=E6zS
-----END PGP SIGNATURE-----
