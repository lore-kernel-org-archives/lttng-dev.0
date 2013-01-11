From: Aaron Spear <aspear@vmware.com>
Subject: Re: tracing of non-JNI java in IBM jvm
Date: Fri, 11 Jan 2013 10:55:37 -0800 (PST)
Message-ID: <439402897.6438391.1357930537656.JavaMail.root__6556.56743697381$1357930596$gmane$org@vmware.com>
References: <A94B468263DDE2448A14367F590EB97301D10B85@ltcfiswmsgmb15>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp-outbound-1.vmware.com ([208.91.2.12])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <aspear@vmware.com>) id 1TtjlX-0001h9-Vr
	for lttng-dev@lists.lttng.org; Fri, 11 Jan 2013 13:55:44 -0500
In-Reply-To: <A94B468263DDE2448A14367F590EB97301D10B85@ltcfiswmsgmb15>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Erik Ostermueller <Erik.Ostermueller@fisglobal.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org


----- Original Message -----
> From: "Erik Ostermueller" <Erik.Ostermueller@fisglobal.com>
> To: "Alexandre Montplaisir" <alexmonthy@voxpopuli.im>
> Cc: lttng-dev@lists.lttng.org
> Sent: Friday, January 11, 2013 9:26:51 AM
> Subject: Re: [lttng-dev] tracing of non-JNI java in IBM jvm
> 
> Thanks Alex for the quick reply....now I get it.
> I'll jump in on that other thread you mentioned.
> 
> There is a tool called InTrace that does some of this work.
> Perhaps some design ideas or even code could be stolen from here:
>  http://mchr3k.github.com/org.intrace/
> This project:
> * implements the java.lang.instrumentation api, which can be used to
> plug a tracing tool into an already-running JVM.
> * allows you to instrument/de-instrument various classes without
> restarting the JVM.
> * Uses http://asm.ow2.org/ to inject byte code for entry/exit tracing
> methods.
> * stores thread id (good) but does nothing to sort/organize activity
> by thread id into a session(bad)
> * no graphing/aggregating of performance metrics...just displays
> entry/exit times, method parameters, etc...

Hi Erik,

I think that what you are mentioning is certainly one thing that is needed. To me I see a couple of different components here:
1) implementation of java.util.logging interfaces as well as SLF4J interfaces, as well as a dedicated LTTng java API for registering
custom event typess.  This would be used for static, compile time instrumentation of java apps.
2) an implementation that uses the tooling you mention above for dynamic instrumentation of any running java app.  You basically would define trace and install trace points on the fly.  This would be really, really powerful.

The implementations of the above would have to be quite different from the way that things are done currently with UST.  Currently UST uses macros in C files to define the various tracepoints statically.  We would need to have API's that could be called dynamically to define tracepoints, so that the java code could do this.  I have not actually looked under the hood with the current UST implementation to see what the implications are for this.  

It seems to me that we would want to have a Java API usage similar to what you can do with SLF4J:

class MyClass {
      private static final Tracer tracer = LTTngFactory.getTracer("MyComponentName");
      private static final String MY_TRACEPOINT = "MyTracepointWithIntegerStringAndLong";

      static {
          // register a tracepoint.  this goes through JNI and creates a tracepoint
          // in UST that has the given name and the specified objects
          tracer.registerTracepoint(MY_TRACEPOINT,
                                     new Object[]{Integer.class,String.class,Long.class});
      }

      public void someMethod() {
          Integer someInteger = 123456;
          String  someString = "this is the string";
          Long  someLong = 56789;

          tracer.trace(MY_TRACEPOINT,someInteger,someString,someLong);
      }
}

Then over the top of this you have implementations of SLF4J, java.util.logging, whatever.  The infrastructure required in the JNI side for this would be the same implementation needed by the binding to the InTrace technology to dynamically create tracepoints.

I need all of this right now, and am willing to spend time in the next few months to implement it.

cheers,
Aaron Spear, Staff Engineer, VMware Inc
