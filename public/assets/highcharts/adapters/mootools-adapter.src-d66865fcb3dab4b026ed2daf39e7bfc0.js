/** 
 * @license Highcharts JS v2.1.6 (2011-07-08)
 * MooTools adapter
 * 
 * (c) 2010-2011 Torstein Hønsi
 * 
 * License: www.highcharts.com/license
 */
// JSLint options:
/*global Highcharts, Fx, $, $extend, $each, $merge, Events, Event */
(function(){var a=window,b=!!a.$merge,c=a.$extend||function(){return Object.append.apply(Object,arguments)};a.HighchartsAdapter={init:function(){var a=Fx.prototype,b=a.start,c=Fx.Morph.prototype,d=c.compute;a.start=function(a,c){var d=this,e=d.element;return a.d&&(d.paths=Highcharts.pathAnim.init(e,e.d,d.toD)),b.apply(d,arguments),this},c.compute=function(a,b,c){var e=this,f=e.paths;if(f)e.element.attr("d",Highcharts.pathAnim.step(f[0],f[1],c,e.toD));else return d.apply(e,arguments)}},animate:function(a,b,d){var e=a.attr,f,g=d&&d.complete;e&&!a.setStyle&&(a.getStyle=a.attr,a.setStyle=function(){var b=arguments;a.attr.call(a,b[0],b[1][0])},a.$family=a.uid=!0),HighchartsAdapter.stop(a),f=new Fx.Morph(e?a:$(a),c({transition:Fx.Transitions.Quad.easeInOut},d)),b.d&&(f.toD=b.d),g&&f.addEvent("complete",g),f.start(b),a.fx=f},each:function(a,c){return b?$each(a,c):a.each(c)},map:function(a,b){return a.map(b)},grep:function(a,b){return a.filter(b)},merge:function(){var a=arguments,c=[{}],d=a.length,e;if(b)e=$merge.apply(null,a);else{while(d--)c[d+1]=a[d];e=Object.merge.apply(Object,c)}return e},addEvent:function(a,b,d){typeof b=="string"&&(b=="unload"&&(b="beforeunload"),a.addEvent||(a.nodeName?a=$(a):c(a,new Events)),a.addEvent(b,d))},removeEvent:function(a,b,c){b?(b=="unload"&&(b="beforeunload"),defined(c)?a.removeEvent(b,c):a.removeEvents(b)):a.removeEvents()},fireEvent:function(a,b,d,e){b=new Event({type:b,target:a}),b=c(b,d),b.preventDefault=function(){e=null},a.fireEvent&&a.fireEvent(b.type,b),e&&e(b)},stop:function(a){a.fx&&a.fx.cancel()}}})()