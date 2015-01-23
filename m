From: Raphael Zulliger <zulliger@indel.ch>
Subject: Re: LTTng unreliable and useless under heavy loaded
	systems?
Date: Fri, 23 Jan 2015 09:09:01 +0100
Message-ID: <54C2019D.1060605__32011.8468291641$1422000595$gmane$org@indel.ch>
References: <54AD5A76.7070004@indel.ch> <54AD654F.4060206@efficios.com>
 <54AE8C05.5070001@indel.ch>
 <983257069.43886.1421439851925.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from ms9.webland.ch ([92.43.217.109])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <mailadmin@indel.ch>) id 1YEZIl-0005It-K3
 for lttng-dev@lists.lttng.org; Fri, 23 Jan 2015 03:09:14 -0500
In-Reply-To: <983257069.43886.1421439851925.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org, Julien Desfossez <jdesfossez@efficios.com>
List-Id: lttng-dev@lists.lttng.org

On 01/16/2015 09:24 PM, Mathieu Desnoyers wrote:
> If you care about not overwriting your buffers under heavy load, I
> recommend to issue "lttng stop; lttng snapshot record" in order to
> stop tracing before gathering the snapshot. This would lessen the
> chances to overwrite your important trace data due to your heavy
> load.
Yeah, that perfectly makes sense. I tried this and it indeed helped to 
not loose a single trace anymore! (without 'lttng stop' some 'snapshots' 
still didn't contain what I was interested in). For the records, this is 
how I currently use LTTng:

     lttng create --snapshot victory
     lttng enable-channel channel0 -k --subbuf-size 16M --num-subbuf 2
     lttng add-context -k -t procname -c channel0
     lttng enable-event -k --all -c channel0
     for i in $(ps -mo tid -p `pgrep lttng-consumerd` | grep -v "TID" | 
grep -v "-"); do sudo chrt -f -p 50 $i; done
     lttng start

     chrt -f 50 ./run_my_test-application_here # this app (programmed in 
C/C++) performs a 'system("lttng stop; lttng snapshot record; lttng 
start");' whenever a certain jitter is reached

     lttng stop
     lttng destroy


I guess the line:
     for i in $(ps -mo tid -p `pgrep lttng-consumerd` | grep -v "TID" | 
grep -v "-"); do sudo chrt -f -p 50 $i; done
wouldn't be necessary anymore (with 'lttng stop') but I didn't try that.

Cheers,
Raphael
