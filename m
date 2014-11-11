From: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Subject: Re: babeltrace CTF -> Text -> CTF
Date: Tue, 11 Nov 2014 08:41:28 -0500
Message-ID: <54621208.7050201__48000.3805984326$1415716899$gmane$org@voxpopuli.im>
References: <CAGfiMvDLEBEHxGz93X_JPV48RTO=N_sD_rb59uwNrppcVv5Yjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <alexmonthy@voxpopuli.im>) id 1XoBhf-0007R2-HJ
 for lttng-dev@lists.lttng.org; Tue, 11 Nov 2014 08:41:59 -0500
In-Reply-To: <CAGfiMvDLEBEHxGz93X_JPV48RTO=N_sD_rb59uwNrppcVv5Yjg@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Divya Vyas <edivya.vyas@gmail.com>, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi,

babeltrace-log is just a small tool that "wraps" a text file in CTF. It 
is not a lossless conversion back to CTF format from a babeltrace 
output. To do that, you would need to do something like:
$ babeltrace -i text -o ctf ...
but that is not supported yet.

So it's expected that the initial CTF file and the one after conversion 
are not exactly the same. Everything will get dumped into the payload, 
among other things.

Cheers,
Alexandre


On 2014-11-11 12:26 AM, Divya Vyas wrote:
> Hi ,
>
> I am Converting the LTTng ouput ( I think this is in CTF format ) into a
> text log using below command :
>
>   babeltrace trace-20141016-071352-kernel/  > text_output
>
>
> The text_output first line is
>
> [12:44:05.438190693] (+?.?????????) kmem_cache_alloc: { cpu_id = 0 }, {
> call_site = 0xFFFFFFFF811806FC, ptr = 0xFFFF8800157248C0, bytes_req = 304,
> bytes_alloc = 320, gfp_flags = 32976 }
>
> missing timestamp
>
> Again I am trying to convert into CTF using babeltrace-log
>
> cat text_output | babeltrace-log -t ctf_output
>
>
> The output of LTTng output and ctf_ouput should be same in eclipse trace
> viewer but I am not able to see ctf_output correctly .
>
> I am not sure whether My steps are wrong?
>
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
