From: Bernd Hufmann <Bernd.Hufmann@ericsson.com>
Subject: Re: [RELEASE] LTTng-tools 2.1.0-rc1
Date: Wed, 22 Aug 2012 08:46:54 -0400
Message-ID: <5034D4BE.7060400__30893.4692330242$1345639658$gmane$org@ericsson.com>
References: <502EA58E.2060003@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from imr4.ericy.com ([198.24.6.9])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <bernd.hufmann@ericsson.com>) id 1T4AKu-0007Ns-Fb
	for lttng-dev@lists.lttng.org; Wed, 22 Aug 2012 08:47:04 -0400
Received: from eusaamw0707.eamcs.ericsson.se ([147.117.20.32])
	by imr4.ericy.com (8.14.3/8.14.3/Debian-9.1ubuntu1) with ESMTP id
	q7MCm6F9009035
	for <lttng-dev@lists.lttng.org>; Wed, 22 Aug 2012 07:48:09 -0500
In-Reply-To: <502EA58E.2060003@efficios.com>
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

Hi David

I've just installed LTTng-tools 2.1.0-rc1 and I wanted to use it with 
the Eclipse LTTng tracer control. First, I added 2.1.x as supported 
version to Eclipse and
then I tried to used it with 2.0.x features. I noticed a few differences 
in the output strings of command outputs [1] as well as the directory 
structure of
generated traces [2]. The Eclipse LTTng tracer control parses the String 
output of the commands to extract relevant information.

Generally, it would be much easier to maintain the Eclipse LTTng tracer 
control if for existing features the string outputs and the directory 
structure are the same
as before. Please note, if someone uses scripts to generate traces the 
output format is also important.

[1] Command output of lttng create mysession:
In v2.0.x the output was:
Session mysession created.
Traces will be written in /home/user/lttng-traces/mysession-20120314-132824

in v2.1.x the output is:
Trace(s) output set to /home/user/lttng-traces/mysession-20120822-082243
Session mysession created.

So, the first and second line are swapped. Also the content of the line 
with the path is changed. Would it be possible, to have the same order 
of the lines and same output as in v2.0.x?

[2] Trace directory structure:
I noticed that the UST traces are moved under another sub-directory.

In v2.0.x the directory structure looked as follows:
/home/user/lttng-traces/
             |-mysession-20120314-132824
                     |-kernel
                          |---<kernel trace files>
                     |-ust
                          |---<programA-<PID>-<date>>
                                           |-----------<program A 
specific trace files>

In v2.1.x the directory structure looked as follows:
/home/user/lttng-traces/
            |-mysession-20120314-132824
                     |-kernel
                          |---<kernel trace files>
                     |-ust
                          |--- mysession-20120314-132824
                                   |---<programA-<PID>-<date>>
                                           |-----------<program A 
specific trace files>

So as you see, under ust there is another sub directory with trace 
session name and date/time. I don't see a practical reason to have this 
sub directory, because the session name and date/time is already known 
from the top-level directory. Is it possible to revert this back? In 
Eclipse I would have to implement a special case for different 
LTTng-tools versions (in the import dialog).

Thank you very much in advance.

Best Regards
Bernd


On 08/17/2012 04:11 PM, David Goulet wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA512
>
> Greetings everyone (including LTTng elves),
>
> The lttng-tools project provides a session daemon (lttng-sessiond)
> that acts as a tracing registry, the "lttng" command line for tracing
> control, a lttng-ctl library for tracing control and a lttng-relayd
> for network streaming.
>
> This is the first release candidate for lttng-tools 2.1 which brings
> two exciting new features, network streaming and filtering support.
>
> It's the combination of a lot of work from the LTTng team so please,
> to help us improve our tools, report any bugs or misbehaving
> feature(s) that you may encounter through this mailing list or the bug
> tracker (https://bugs.lttng.org).
>
> - From now on, lttng-tools is in feature freeze mode unless an *IMMENSE*
> show stopper is found.
>
> 2012-08-17 lttng-tools 2.1.0-rc1
>      * Feature: Network Streaming
>      * Add the lttng-relayd binary for network streaming
>      * Support user space tracer filtering
>      * Multiple fixes
>
> Project website: http://lttng.org/lttng2.0
> Download link:
> http://lttng.org/files/lttng-tools/lttng-tools-2.1.0-rc1.tar.bz2
>
> Cheers!
> David
> -----BEGIN PGP SIGNATURE-----
>
> iQEcBAEBCgAGBQJQLqWLAAoJEELoaioR9I023WUH+gNuU+NL0gZInlFbFiqGG5n8
> DyvtZaUOtHr7ZoSU2cmEcNfgxzOj0jTt5lGPm7EaU7X5OUiQCiu8gz5kKsL0h5PW
> UPZ7DbGHxv8JQQCt/Ac6cydlOjbRT1fB/5GXGT+OX+g/Xzp+Utb6vrTCWCC0RvSO
> 01U2NK2+IWTuRTol7ykK1WWqTStQSKPZ6ncdYjgq1FJu2gakQA4RnhblMbXWCuP9
> EZPxafSaH19mHlhDiDmtdTl7hcWTPAd0u+qNoq7kmh+stcNSn2zjv/bNldbNfaHI
> m0kfl8NferiyRpyeD4CgNtFE5W4jm29NId7IRI14/Ow8psZegF8SNlAL76Puqo8=
> =PU4p
> -----END PGP SIGNATURE-----
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
